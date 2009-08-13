require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_belong_to :host

  should_have_named_scope :alphabetized, :order => :username

  should_have_readonly_attributes :username
  should_allow_mass_assignment_of :password

  should_not_allow_mass_assignment_of :email
  should_not_allow_mass_assignment_of :local_email
  should_not_allow_mass_assignment_of :mailbox_path

  should_validate_presence_of :username
  should_validate_presence_of :password

  context 'with an existing account' do
    setup { Account.make }
    should_validate_uniqueness_of :username, :scoped_to => :host_id
  end

  should 'normalize username' do
    Account.make(:username => ' Fred ').username.should == 'fred'
  end

  should 'generate email' do
    host    = Host.make(:name => 'example.com')
    account = host.accounts.make(:username => 'bob')
    account.email.should == 'bob@example.com'
  end

  should 'generate local_email' do
    host    = Host.make(:name => 'example.com')
    account = host.accounts.make(:username => 'bob')
    account.local_email.should == 'bob@example.com.local'
  end

  should 'generate mailbox_path' do
    host    = Host.make(:name => 'example.com')
    account = host.accounts.make(:username => 'bob')
    account.mailbox_path.should == 'example.com/bob'
  end
end
