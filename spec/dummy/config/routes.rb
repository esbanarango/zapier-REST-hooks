Rails.application.routes.draw do

  mount ZapierRestHooks::Engine => "/zapier_rest_hooks"
end
