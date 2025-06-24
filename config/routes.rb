Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resources :passwords, param: :token

  get "/login", to: "sessions#new"

  root "static#index"
end
