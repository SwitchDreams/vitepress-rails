# frozen_string_literal: true

require "high_voltage/page_finder"

class Vitepress::Rails::Finder < HighVoltage::PageFinder
  def find
    super.chomp(".html")
  end
end
