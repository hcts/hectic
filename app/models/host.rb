class Host < ActiveRecord::Base
  validates_presence_of :smtp_server_name
  validates_presence_of :smtp_server_port
  validates_presence_of :smtp_server_username
  validates_presence_of :smtp_server_password

  validates_numericality_of :smtp_server_port

  before_save :generate_smtp_server_address
  before_save :generate_smtp_server_credentials

  private

  def generate_smtp_server_address
    self.smtp_server_address = "[#{smtp_server_name}]:#{smtp_server_port}"
  end

  def generate_smtp_server_credentials
    self.smtp_server_credentials = "#{smtp_server_username}:#{smtp_server_password}"
  end
end
