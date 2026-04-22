# frozen_string_literal: true

require_relative "rails/version"
require "vitepress/rails/version"
require "vitepress/engine"
require "vitepress/rails/tasks"

module Vitepress
  require "vitepress/railtie" if defined?(Rails)

  module Rails
    class Error < StandardError; end
  end
end
