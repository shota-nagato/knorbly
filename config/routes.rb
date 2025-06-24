Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resources :passwords, param: :token

  get "/login", to: "sessions#new"

  resources :component_styles, only: [ :index ]

  root "static#index"
end
