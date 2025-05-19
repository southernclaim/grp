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

  spec.files       = ["lib/grp.rb", "bin/grp"] 
  spec.executables << "grp"
  spec.add_dependency "optparse"
  spec.add_dependency "colorize"

end
