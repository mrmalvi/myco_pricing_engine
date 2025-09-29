# frozen_string_literal: true

require_relative "lib/myco_pricing_engine/version"

Gem::Specification.new do |spec|
  spec.name = "myco_pricing_engine"
  spec.version = MycoPricingEngine::VERSION
  spec.authors = ["mrmalvi"]
  spec.email = ["malviyak00@gmail.com"]

  spec.summary       = "Dynamic pricing engine with loyalty, tax, and coupon rules"
  spec.description   = "A configurable pricing engine for Rails/e-commerce apps that supports loyalty points, regional taxes, and flexible coupon logic."
  spec.homepage      = "https://github.com/mrmalvi/myco_pricing_engine"
  spec.required_ruby_version = ">= 2.0.0"

  spec.metadata["homepage_uri"]     = spec.homepage
  spec.metadata["source_code_uri"]  = "https://github.com/mrmalvi/myco_pricing_engine"
  spec.metadata["changelog_uri"]    = "https://github.com/mrmalvi/myco_pricing_engine/blob/main/CHANGELOG.md"

  spec.add_dependency "activesupport", ">= 6.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      f == gemspec || f.end_with?('.gem') || f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
