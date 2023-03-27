# frozen_string_literal: true

# Inspired from https://github.com/thoughtbot/high_voltage/blob/main/app/controllers/concerns/high_voltage/static_page.rb
require "vitepress/rails/finder"

module Vitepress::Page
  extend ActiveSupport::Concern

  included do
    layout ->(_) { HighVoltage.layout }

    rescue_from ActionView::MissingTemplate do |exception|
      if /Missing template #{page_finder.content_path}/.match?(exception.message)
        invalid_page
      else
        raise exception
      end
    end

    rescue_from HighVoltage::InvalidPageIdError, with: :invalid_page
  end

  def show
    render(
      template: current_page,
      locals: { current_page: current_page },
    )
  end

  def invalid_page
    raise ActionController::RoutingError, "No such page: #{params[:id]}"
  end

  private

  def current_page
    page_finder.find
  end

  def page_finder
    page_finder_factory.new(params[:id])
  end

  def page_finder_factory
    Vitepress::Rails::Finder
  end
end
