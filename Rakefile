# frozen_string_literal: true

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'juwelier'
require_relative 'lib/active_record_array_enum/version'

Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name                  = "activerecord_array_enum"
  gem.version               = ActiveRecordArrayEnum::VERSION::STRING
  gem.homepage              = "https://github.com/magellan-ai/activerecord_array_enum"
  gem.license               = "MIT"
  gem.summary               = "Adds array functionality built on ActiveRecord's enums."
  gem.description           = "Adds array functionality built on ActiveRecord's enums."
  gem.email                 = "ryan@magellan.ai"
  gem.authors               = ["Ryan Kerr", "Gregory Nelson", "William Dana", "Rex Madden"]
  gem.required_ruby_version = '>= 2.7'

  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task simplecov: :environment do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task default: :spec

require 'rdoc/task'

Rake::RDocTask.new do |rdoc|
  version = ActiveRecordArrayEnum::VERSION::STRING

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = "activerecord_array_enum #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
