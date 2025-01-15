# frozen_string_literal: true

require_relative "lib/annotate_model/version"

Gem::Specification.new do |spec|
  spec.name = "annotate_model"
  spec.version = AnnotateModel::VERSION
  spec.authors = ["Taeyang Lee"]
  spec.email = ["taeyang91@gmail.com"]

  spec.summary = "Annotates Rails models with database schema information."
  spec.description = "A lightweight gem to annotate Rails models based on the database schema."
  spec.homepage = "https://github.com/taeyang91/annotate_model"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = Dir["lib/**/*", "exe/*", "README.md", "LICENSE.txt"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
