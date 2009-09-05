class Account < ActiveRecord::Base
  belongs_to :host

  named_scope :alphabetized, :order => :username

  attr_readonly   :username
  attr_accessible :username
  attr_accessible :password
  attr_accessible :ignore_password_errors
  attr_accessor   :ignore_password_errors
  attr_accessible :limit_in_kilobytes
  attr_writer     :limit_in_kilobytes

  before_validation :normalize_username

  validates_presence_of   :username
  validates_uniqueness_of :username, :scope => :host_id

  validates_presence_of :password
  validates_length_of   :password, :minimum => 8, :unless => :ignore_password_errors
  validates_format_of   :password, :with => /([A-Za-z].*){3}/, :message => 'must contain at least 3 letters', :unless => :ignore_password_errors
  validates_format_of   :password, :with => /(\d.*){3}/,       :message => 'must contain at least 3 numbers', :unless => :ignore_password_errors

  validates_numericality_of :limit_in_kilobytes, :only_integer => true, :greater_than_or_equal_to => 0, :message => 'must be 0 or a positive integer'

  before_save :generate_email
  before_save :generate_limit
  before_save :generate_local_email
  before_save :generate_mailbox_path

  def limit_in_kilobytes
    @limit_in_kilobytes ||= limit / 1024
  end

  private

  def normalize_username
    self.username = self.username.to_s.strip.downcase
  end

  def generate_email
    self.email = "#{username}@#{host.name}"
  end

  def generate_limit
    self.limit = limit_in_kilobytes.to_i.kilobytes
  end

  def generate_local_email
    self.local_email = "#{username}@#{host.local_name}"
  end

  def generate_mailbox_path
    self.mailbox_path = "#{host.name}/#{username}"
  end

  alias_method :limit_in_kilobytes_before_type_cast, :limit_in_kilobytes
end
