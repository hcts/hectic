ENV['RAILS_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require 'test_help'

if $stdin.tty?
  require 'redgreen' rescue nil
end

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

Host.blueprint do
  name          { Faker::Internet.domain_name }
  smtp_username { Faker::Internet.user_name }
  smtp_password { Faker.letterify('????????') }
end

Account.blueprint do
  host
  username { Faker::Internet.user_name }
  password { Faker.letterify('????????') }
end