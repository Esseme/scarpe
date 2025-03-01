# frozen_string_literal: true

require_relative "lib/lacci/version"

Gem::Specification.new do |spec|
  spec.name = "lacci"
  spec.version = Lacci::VERSION
  spec.authors = ["Marco Concetto Rudilosso", "Noah Gibbs"]
  spec.email = ["marcoc.r@outlook.com", "the.codefolio.guy@gmail.com"]

  spec.summary = "Lacci - a portable Shoes DSL with switchable display backends, part of Scarpe"
  spec.homepage = "https://github.com/scarpe-team/scarpe"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/scarpe-team/scarpe"
  spec.metadata["changelog_uri"] = "https://github.com/scarpe-team/scarpe/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #spec.add_dependency ""

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
