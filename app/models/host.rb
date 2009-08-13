class Host < ActiveRecord::Base
  has_many :accounts

  named_scope :alphabetized, :order => :name

  attr_readonly   :name
  attr_accessible :name
  attr_accessible :pop_server
  attr_accessible :smtp_server

  before_validation :normalize_name

  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :generate_local_name
  before_save :generate_pop_server,  :unless => :pop_server?
  before_save :generate_smtp_server, :unless => :smtp_server?

  private

  def normalize_name
    self.name = self.name.to_s.strip.downcase
  end

  def generate_local_name
    self.local_name = "#{name}.local"
  end

  def generate_pop_server
    self.pop_server = "pop.#{name}"
  end

  def generate_smtp_server
    self.smtp_server = "[smtp.#{name}]:587"
  end
end
