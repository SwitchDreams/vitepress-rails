# frozen_string_literal: true

require "high_voltage"

HighVoltage.configure do |config|
  config.route_drawer = HighVoltage::RouteDrawers::Default
  config.parent_engine = Vitepress::Engine
  config.routes = false
end
