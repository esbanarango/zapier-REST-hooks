Rails.application.routes.draw do
  mount ZapierRestHooks::Engine => '/hooks'
end
