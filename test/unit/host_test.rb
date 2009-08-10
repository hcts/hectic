require 'test_helper'

class HostTest < ActiveSupport::TestCase
  should_validate_presence_of :smtp_server_name
  should_validate_presence_of :smtp_server_port
  should_validate_presence_of :smtp_server_username
  should_validate_presence_of :smtp_server_password

  should_validate_numericality_of :smtp_server_port

  should 'generate smtp_server_address' do
    host = Host.make(:smtp_server_name => 'example.com', :smtp_server_port => 465)
    host.smtp_server_address.should == '[example.com]:465'
  end

  should 'generate smtp_server_credentials' do
    host = Host.make(:smtp_server_username => 'bob', :smtp_server_password => 'foo')
    host.smtp_server_credentials.should == 'bob:foo'
  end
end
