# frozen_string_literal: true

module Vitepress
  class Engine < ::Rails::Engine
    isolate_namespace Vitepress

    initializer :load_config_initializers do
      config.paths["config/initializers"].existent.sort.each do |initializer|
        load_config_initializer(initializer)
      end
    end
  end
end
