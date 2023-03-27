# frozen_string_literal: true

require "rails/railtie"

module Vitepress
  class Railtie < ::Rails::Railtie
    railtie_name :vitepress

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/**/*.rake").each { |f| load f }
    end
  end
end
