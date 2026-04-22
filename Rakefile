# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "vitepress/rails"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: [:spec, :rubocop]

# Load custom rake tasks
path = File.expand_path(__dir__)
Dir.glob("#{path}/lib/vitepress/tasks/**/*.rake").each { |f| import f }
