ZapierRestHooks::Engine.routes.draw do
  resources :hooks, only: [:create, :destroy]
end
