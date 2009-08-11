class Host < ActiveRecord::Base
  has_many :accounts

  default_scope   :order => :name

  attr_readonly   :name
  attr_accessible :name
  attr_accessible :pop_server
  attr_accessible :smtp_server
  attr_accessible :smtp_username
  attr_accessible :smtp_password

  before_validation :normalize_name

  validates_presence_of :name
  validates_presence_of :smtp_username
  validates_presence_of :smtp_password
  validates_uniqueness_of :name

  attr_writer :smtp_username
  attr_writer :smtp_password

  before_save :generate_pop_server,  :unless => :pop_server?
  before_save :generate_smtp_server, :unless => :smtp_server?
  before_save :generate_smtp_credentials

  def smtp_username
    @smtp_username ||= smtp_credentials? ? smtp_credentials.split(':').first : nil
  end

  def smtp_password
    @smtp_password ||= smtp_credentials? ? smtp_credentials.split(':').last : nil
  end

  private

  def normalize_name
    self.name = self.name.to_s.strip.downcase
  end

  def generate_pop_server
    self.pop_server = "pop.#{name}"
  end

  def generate_smtp_server
    self.smtp_server = "[smtp.#{name}]:587"
  end

  def generate_smtp_credentials
    self.smtp_credentials = "#{smtp_username}:#{smtp_password}"
  end
end
