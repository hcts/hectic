require 'test_helper'

class HostTest < ActiveSupport::TestCase
  should_have_many :accounts

  should_have_readonly_attributes :name
  should_allow_mass_assignment_of :pop_server
  should_allow_mass_assignment_of :smtp_server
  should_not_allow_mass_assignment_of :local_name

  should_validate_presence_of :name

  context 'with an existing host' do
    setup { Host.make }
    should_validate_uniqueness_of :name
  end

  should 'normalize name' do
    Host.make(:name => ' Example.COM ').name.should == 'example.com'
  end

  should 'generate local_name' do
    host = Host.make(:name => 'example.com')
    host.local_name.should == 'example.com.local'
  end

  should 'generate pop_server' do
    host = Host.make(:name => 'example.com')
    host.pop_server.should == 'pop.example.com'
  end

  should 'generate smtp_server' do
    host = Host.make(:name => 'example.com')
    host.smtp_server.should == '[smtp.example.com]:587'
  end
end
