bundle_path 'vendor/bundler_gems'
clear_sources
source 'http://gemcutter.org'

gem 'rails',    '2.3.4'
gem 'haml',     '2.2.3'
gem 'rrdb',     '0.0.2', :git => 'git://github.com/JEG2/rrdb.git', :commit => '6935419'
gem 'snmp',     '1.0.2'
gem 'whenever', '0.4.0'

only :test do
  gem 'faker',     '0.3.1'
  gem 'matchy',    '0.3.1', :git => 'http://github.com/jeremymcanally/matchy.git', :commit => '2e01918'
  gem 'machinist', '1.0.5', :require_as => 'machinist/active_record'
  gem 'mocha',     '0.9.5', :require_as => []
  gem 'redgreen',  '1.2.2', :require_as => []
  gem 'shoulda',   '2.10.2'
end
