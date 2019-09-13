# frozen_string_literal: true

ZapierRestHooks::Engine.routes.draw do
  resources :hooks, only: %i(create destroy)
end
