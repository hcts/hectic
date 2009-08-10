require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  should_belong_to :host

  should_have_readonly_attributes :username
  should_allow_mass_assignment_of :password

  should_not_allow_mass_assignment_of :public_email
  should_not_allow_mass_assignment_of :private_email
  should_not_allow_mass_assignment_of :mailbox_path

  should_validate_presence_of :username
  should_validate_presence_of :password

  should 'generate public_email' do
    host    = Host.make(:name => 'example.com')
    account = host.accounts.make(:username => 'bob')
    account.public_email.should == 'bob@example.com'
  end

  should 'generate private_email' do
    host    = Host.make(:name => 'example.com')
    account = host.accounts.make(:username => 'bob')
    account.private_email.should == 'bob@example.com.local'
  end

  should 'generate mailbox_path' do
    host    = Host.make(:name => 'example.com')
    account = host.accounts.make(:username => 'bob')
    account.mailbox_path.should == 'example.com/bob'
  end
end
