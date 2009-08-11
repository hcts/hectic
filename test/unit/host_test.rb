require 'test_helper'

class HostTest < ActiveSupport::TestCase
  should_have_many :accounts

  should_have_readonly_attributes :name

  should_allow_mass_assignment_of :smtp_username
  should_allow_mass_assignment_of :smtp_password
  should_allow_mass_assignment_of :pop_server
  should_allow_mass_assignment_of :smtp_server

  should_not_allow_mass_assignment_of :smtp_credentials

  should_validate_presence_of :name
  should_validate_presence_of :smtp_username
  should_validate_presence_of :smtp_password

  context 'with an existing host' do
    setup { Host.make }
    should_validate_uniqueness_of :name
  end

  should 'normalize name' do
    Host.make(:name => ' Example.COM ').name.should == 'example.com'
  end

  should 'generate pop_server' do
    host = Host.make(:name => 'example.com')
    host.pop_server.should == 'pop.example.com'
  end

  should 'generate smtp_server' do
    host = Host.make(:name => 'example.com')
    host.smtp_server.should == '[smtp.example.com]:587'
  end

  should 'generate smtp_credentials' do
    host = Host.make(:smtp_username => 'bob', :smtp_password => 'foo')
    host.smtp_credentials.should == 'bob:foo'
  end

  should 'parse smtp_credentials' do
    host = Host.make(:smtp_username => 'bob', :smtp_password => 'foo')
    host = Host.find(host.id)
    host.smtp_username.should == 'bob'
    host.smtp_password.should == 'foo'
  end
end
