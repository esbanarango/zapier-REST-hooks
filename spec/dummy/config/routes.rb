# frozen_string_literal: true

Rails.application.routes.draw do
  mount ZapierRestHooks::Engine => '/hooks'
end
