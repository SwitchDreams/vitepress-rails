# frozen_string_literal: true

class Vitepress::PagesController < ActionController::Base
  include Vitepress::Page

  layout false

  def index
    render(
      template: "pages/index",
      locals: { current_page: "pages/index" },
    )
  end
end
