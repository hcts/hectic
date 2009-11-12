bundle_path 'vendor/bundler_gems'
disable_system_gems
clear_sources
source 'http://gemcutter.org'
source 'http://gems.github.com'

gem 'rails', '= 2.3.4'
gem 'haml',  '= 2.2.3'

only :development, :test do
  gem 'sqlite3-ruby', '= 1.2.4'
end

only :test do
  gem 'faker',                 '= 0.3.1'
  gem 'jeremymcanally-matchy', '= 0.1.0', :require_as => 'matchy'
  gem 'machinist',             '= 1.0.5', :require_as => 'machinist/active_record'
  gem 'redgreen',              '= 1.2.2'
  gem 'shoulda',               '= 2.10.2'
end
