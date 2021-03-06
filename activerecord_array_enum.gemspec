# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# frozen_string_literal: true

# stub: activerecord_array_enum 0.0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name                              = "activerecord_array_enum"
  s.version                           = "0.0.3.0"

  s.required_rubygems_version         = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths                     = ["lib"]
  s.authors                           = ["Ryan Kerr", "Gregory Nelson", "Rex Madden"]
  s.description                       = "Adds array functionality built on ActiveRecord's enums."
  s.email                             = "ryan@magellan.ai"
  s.extra_rdoc_files                  =
    [
      "LICENSE.txt",
      "README.md"
    ]
  s.files                             =
    [
      ".document",
      ".rspec",
      ".rubocop.yml",
      ".ruby-gemset",
      ".ruby-version",
      "Appraisals",
      "Gemfile",
      "Gemfile.lock",
      "LICENSE.txt",
      "README.md",
      "Rakefile",
      "activerecord_array_enum.gemspec",
      "lib/active_record_array_enum.rb",
      "lib/active_record_array_enum/array_enum_methods.rb",
      "lib/active_record_array_enum/array_enum_type.rb",
      "lib/active_record_array_enum/railtie.rb",
      "lib/active_record_array_enum/subset_validator.rb",
      "lib/active_record_array_enum/version.rb",
      "spec/spec_helper.rb"
    ]
  s.homepage                          = "https://github.com/magellan-ai/activerecord_array_enum"
  s.licenses                          = ["MIT"]
  s.required_ruby_version             = Gem::Requirement.new(">= 2.7")
  s.rubygems_version                  = "3.1.6"
  s.summary                           = "Adds array functionality built on ActiveRecord's enums."

  s.specification_version             = 4 if s.respond_to? :specification_version

  if s.respond_to? :add_runtime_dependency
    s.add_runtime_dependency('activerecord', [">= 6.1"])
    s.add_development_dependency('appraisal', [">= 0"])
    s.add_development_dependency('bundler', [">= 1.0"])
    s.add_development_dependency('juwelier', ["~> 2.1.0"])
    s.add_development_dependency('rdoc', ["~> 3.12"])
    s.add_development_dependency('rspec', ["~> 3.5.0"])
    s.add_development_dependency('rubocop-rails', [">= 0"])
    s.add_development_dependency('simplecov', [">= 0"])
  else
    s.add_dependency('activerecord', [">= 6.1"])
    s.add_dependency('appraisal', [">= 0"])
    s.add_dependency('bundler', [">= 1.0"])
    s.add_dependency('juwelier', ["~> 2.1.0"])
    s.add_dependency('rdoc', ["~> 3.12"])
    s.add_dependency('rspec', ["~> 3.5.0"])
    s.add_dependency('rubocop-rails', [">= 0"])
    s.add_dependency('simplecov', [">= 0"])
  end
  s.metadata['rubygems_mfa_required'] = 'true'
end
