class NetworkInterface < ActiveRecord::Base
  PERIODS = %w(day week month year)

  before_destroy :destroy_artifacts

  def self.tick_each!
    find_each(&:tick!)
  end

  def tick!
    download = snmp_fetch(:ifInOctets, :indexed => true)
    upload   = snmp_fetch(:ifOutOctets, :indexed => true)

    store(Time.now, :download => download, :upload => upload)
    update_graphs!

    touch
  end

  def each_graph_url
    document_root = Rails.root.join('public')

    PERIODS.each do |period|
      path = graph_path(period)

      if path.exist?
        yield '/' + path.relative_path_from(document_root)
      end
    end
  end

  def description
    @description ||= snmp_fetch('sysDescr.0')
  end

  def interface_description
    @interface_description ||= snmp_fetch('ifDescr', :indexed => true)
  end

  private

  def snmp_fetch(key, options={})
    key = "#{key}.#{snmp_index}" if options[:indexed]

    SNMP::Manager.open(:Host => host) do |manager|
      manager.get_value(key)
    end
  end

  # RRDtool configuration and doc lifted directly from the tutorial:
  # http://oss.oetiker.ch/rrdtool/tut/rrdtutorial.en.html#IA_Real_World_Example
  #
  # Let the fun begin. First, create a new database. It contains data from two
  # counters, called input and output. The data is put into archives that
  # average it. They take 1, 6, 24 or 288 samples at a time. They also go into
  # archives that keep the maximum numbers. This will be explained later on.
  # The time in-between samples is 300 seconds, a good starting point, which
  # is the same as five minutes.
  #
  #  1 sample "averaged" stays 1 period of 5 minutes
  #  6 samples averaged become one average on 30 minutes
  #  24 samples averaged become one average on 2 hours
  #  288 samples averaged become one average on 1 day
  #
  # Let's try to be compatible with MRTG which stores about the following
  # amount of data:
  #
  #  600 5-minute samples:    2   days and 2 hours
  #  600 30-minute samples:  12.5 days
  #  600 2-hour samples:     50   days
  #  732 1-day samples:     732   days
  #
  # These ranges are appended, so the total amount of data stored in the
  # database is approximately 797 days. RRDtool stores the data differently,
  # it doesn't start the "weekly" archive where the "daily" archive stopped.
  # For both archives the most recent data will be near "now" and therefore we
  # will need to keep more data than MRTG does!
  #
  # We will need:
  #
  #  600 samples of 5 minutes  (2 days and 2 hours)
  #  700 samples of 30 minutes (2 days and 2 hours, plus 12.5 days)
  #  775 samples of 2 hours    (above + 50 days)
  #  797 samples of 1 day      (above + 732 days, rounded up to 797)
  #
  #    rrdtool create myrouter.rrd         \
  #             DS:input:COUNTER:600:U:U   \
  #             DS:output:COUNTER:600:U:U  \
  #             RRA:AVERAGE:0.5:1:600      \
  #             RRA:AVERAGE:0.5:6:700      \
  #             RRA:AVERAGE:0.5:24:775     \
  #             RRA:AVERAGE:0.5:288:797    \
  #             RRA:MAX:0.5:1:600          \
  #             RRA:MAX:0.5:6:700          \
  #             RRA:MAX:0.5:24:775         \
  #             RRA:MAX:0.5:288:797
  #
  RRDB.config(
    :database_directory =>
      Rails.root.join('public', 'system', table_name).tap(&:mkpath),
    :data_sources =>
      'COUNTER:600:U:U',
    :round_robin_archives => [
      'AVERAGE:0.5:1:600',
      'AVERAGE:0.5:6:700',
      'AVERAGE:0.5:24:775',
      'AVERAGE:0.5:288:797',
      'MAX:0.5:1:600',
      'MAX:0.5:6:700',
      'MAX:0.5:24:775',
      'MAX:0.5:288:797'
    ]
  )

  def rrdb
    @rrdb ||= RRDB.new(self.id)
  end

  def store(time, data)
    rrdb.update(time, data)
  end

  def update_graphs!
    PERIODS.each { |period| create_graph(period) }
  end

  def create_graph(period)
    rrdb.class.run_command("#{rrdb.class.config[:rrdtool_path]} graph #{graph_path(period)} --start -#{1.send(period)} --title #{period.humanize} DEF:download=#{rrdb.path}:download:AVERAGE DEF:upload=#{rrdb.path}:upload:AVERAGE AREA:download#00FF00:'Download' LINE1:upload#0000FF:'Upload'")
  end

  def graph_path(period)
    Pathname.new(rrdb.path).dirname.join("#{self.id}-#{period}.png")
  end

  def destroy_artifacts
    File.delete(rrdb.path)

    PERIODS.each do |period|
      File.delete(graph_path(period))
    end
  end
end
