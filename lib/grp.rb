# frozen_string_literal: true
require "colorize"
require_relative "grp/version"
require "optparse"

module Grp
  class Install
    def self.ask_and_download
      puts "Git repository: (username/repo)".colorize(:grey)
      repo_input = gets.chomp
      username, repo = repo_input.split("/", 2)
      unless username && repo
        puts "Invalid format. Use username/repo.".colorize(:red)
        exit
      end
      puts "==> Installing #{repo_input}...".colorize(:green)
      begin
        success = system("git clone -q https://github.com/#{username}/#{repo} #{repo}")
        unless success
          puts "Repository not found or clone failed.".colorize(:red)
          exit
        end
      rescue => e
        puts "An error occurred: #{e.message}".colorize(:red)
        exit
      end
      puts "==> Repository downloaded!".colorize(:green)
      system("cd #{repo}")
      puts "==> Trying to find a install.grp in #{repo}".colorize(:green)
      if File.exist?(File.join(repo, "install.grp"))
        puts "install.grp found in #{repo}".colorize(:green)
        puts "==> Installing #{repo}..."
        system("ruby install.grp")
      else
        puts "install.grp not found in #{repo}".colorize(:red)
      end
      exit
    end

    def self.newinstall
      puts "==> Creating a new install.grp in your current directory #{`pwd`.strip}".colorize(:green)
      system("wget -q https://raw.githubusercontent.com/southernclaim/grp/refs/heads/main/example/install.grp")
      exit
    end
  end
  class Error < StandardError; end
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: grp [options]".colorize(:green)

    opts.on("-h", "--help", "Show this help message") do
      puts opts
      exit
    end

    opts.on("-v", "--version", "Show program version") do
      options[:version] = true
    end

    opts.on("-i", "--install", "Install a program from a git repo") do
      Install::ask_and_download
    end

    opts.on("-n", "--new", "Create a new ./install.grp in your current directory") do
      Install::newinstall
    end

    opts.separator ""
    opts.separator "You are using GRP!".colorize(:green)

  end.parse!

  if options[:version]
    puts "Version 0.1.2"
    exit
  end

  puts "Selected options: #{options}" unless options.empty?
  puts "No options provided. Use -h for help." if options.empty? && ARGV.empty?
end
