# frozen_string_literal: true

Vitepress::Engine.routes.draw do
  get "/*id", to: "pages#show", as: :page, format: false
  root to: "pages#index"
end
