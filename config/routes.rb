Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resource :registration, only: %i[ new create ]
  resources :passwords, param: :token

  get "/login", to: "sessions#new"
  get "/signup", to: "registrations#new"

  resources :component_styles, only: %i[ index ]

  get "/dashboard", to: "dashboard#index", as: :dashboard

  namespace :settings do
    resource :profile, only: %i[ edit update ]
  end

  get "/settings/profile", to: "settings/profiles#edit"

  root "static#index"
end
