class Account < ActiveRecord::Base
  belongs_to :host

  default_scope   :order => :username

  attr_readonly   :username
  attr_accessible :username
  attr_accessible :password

  before_validation :normalize_username

  validates_presence_of :username
  validates_presence_of :password
  validates_uniqueness_of :username, :scope => :host_id

  before_save :generate_public_email
  before_save :generate_private_email
  before_save :generate_mailbox_path

  private

  def normalize_username
    self.username = self.username.to_s.strip.downcase
  end

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
