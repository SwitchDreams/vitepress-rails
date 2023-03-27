# frozen_string_literal: true

require_relative "lib/vitepress/rails/version"

Gem::Specification.new do |spec|
  spec.name = "vitepress-rails"
  spec.version = Vitepress::Rails::VERSION
  spec.authors = ["PedroAugustoRamalhoDuarte"]
  spec.email = ["pedroaugustorduarte@gmail.com"]

  spec.summary = "Vitepress for rails"
  spec.homepage = "https://github.com/SwitchDreams/rest-api-generator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/SwitchDreams/vitepress-rails"
  spec.metadata["changelog_uri"] = "https://github.com/SwitchDreams/vitepress-rails"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["lib/**/*.rb"] + Dir["lib/tasks/*.rake"]

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "high_voltage", "~> 3.1"
  spec.add_dependency "rails", ">= 5.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
