# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :gems do
  desc 'Drop out a gems.yml dependency listing for chef-deploy.'
  task :yaml => :environment do
    gems = Rails.configuration.gems.map do |gem|
      # I don't include the :version because chef-deploy wants a literal
      # string, like "0.7.4", while all I can get from the Rails configuration
      # is a list of '>= 0' kinds of things. Maybe it would be better to read
      # the file for version specifications, and then re-generate it without
      # clobbering.
      { :name => gem.name }
    end

    Rails.root.join('gems.yml').open('w') do |file|
      YAML.dump(gems, file)
    end
  end
end
