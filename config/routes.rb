Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resource :registration, only: %i[ new create ]
  resources :passwords, param: :token

  get "/login", to: "sessions#new"
  get "/signup", to: "registrations#new"
  get "/auth/:provider/callback", to: "sessions#omniauth"

  resources :component_styles, only: %i[ index ]

  get "/dashboard", to: "dashboard#index", as: :dashboard

  resources :folders, param: :slug
  resources :sources do
    resources :source_subscriptions, only: %i[ create ]
  end

  namespace :search do
    resources :feeds, only: %i[ index show ], param: :slug do
      collection do
        post :search
        get :list
      end
    end
  end

  namespace :settings do
    resource :profile, only: %i[ edit update ]
    resource :team, only: %i[ edit update ]
  end

  get "/settings/profile", to: "settings/profiles#edit"
  get "/settings/team", to: "settings/teams#edit"

  root "static#index"
end
