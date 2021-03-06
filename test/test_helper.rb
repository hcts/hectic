ENV['RAILS_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require 'test_help'
require 'mocha'
require 'redgreen' if $stdin.tty?

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

Host.blueprint do
  name { Faker::Internet.domain_name }
end

Account.blueprint do
  host
  username { Faker::Internet.user_name }
  password { Faker.bothify('??#??#??#') }
end
