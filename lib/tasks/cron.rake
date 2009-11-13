task :cron => :environment do
  NetworkInterface.find_each(&:tick!)
end
