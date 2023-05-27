# frozen_string_literal: true

require_relative "lib/japanese_holiday/version"

Gem::Specification.new do |spec|
  spec.name = "japanese_holiday"
  spec.version = JapaneseHoliday::VERSION
  spec.authors = ["t.hirashima"]
  spec.email = ["hira9603859504@gmail.com"]

  github_url = "https://github.com/Hee-San/japanese_holiday"

  spec.summary = "List of Japanese national holidays"
  spec.description = "The list is automatically updated based on the list published by the Cabinet Office of Japan."
  spec.homepage = github_url
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = github_url
  spec.metadata["changelog_uri"] = "#{github_url}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
