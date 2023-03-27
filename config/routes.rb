# frozen_string_literal: true

Vitepress::Engine.routes.draw do
  get "/:id", to: "pages#show", as: :page
  root to: "pages#index"
end
