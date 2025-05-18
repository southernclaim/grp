# frozen_string_literal: true

require_relative "lib/grp/version"

Gem::Specification.new do |spec|
  spec.name = "grp"
  spec.version = Grp::VERSION
  spec.authors = ["Iago Dórea"]
  spec.email = ["iagodorea@proton.me"]

  spec.summary = "A Github Repository Installer"
  spec.description = "Install programs hosted in github faster with grp"
  spec.homepage = "https://github.com/southernclaim/grp"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/southernclaim/grp"
  spec.metadata["changelog_uri"] = "https://github.com/southernclaim/grp/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "optparse"
  spec.add_dependency "colorize"

end
