class Account < ActiveRecord::Base
  belongs_to :host

  attr_readonly   :username
  attr_accessible :password

  validates_presence_of :username
  validates_presence_of :password

  before_save :generate_public_email
  before_save :generate_private_email
  before_save :generate_mailbox_path

  private

  def generate_public_email
    self.public_email = "#{username}@#{host.name}"
  end

  def generate_private_email
    self.private_email = "#{username}@#{host.name}.local"
  end

  def generate_mailbox_path
    self.mailbox_path = "#{host.name}/#{username}"
  end
end
