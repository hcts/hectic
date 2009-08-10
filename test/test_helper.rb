ENV['RAILS_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require 'test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

Host.blueprint do
  smtp_server_name     { Faker::Internet.domain_name }
  smtp_server_port     { Faker.numerify('####') }
  smtp_server_username { Faker::Internet.user_name }
  smtp_server_password { Faker.letterify('????????') }
end