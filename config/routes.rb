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

  resources :items, only: %i[ index ] do
    collection do
      post :search
    end
  end

  resources :folders, param: :slug do
    resource :position, module: :folders, only: %i[ update ]
    resources :items, module: :folders do
      collection do
        post :search
      end
    end
    resources :sources, module: :folders, only: %i[ index ]
  end

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

  namespace :admin do
    root to: "dashboard#index"
    resources :sources
  end

  root "static#index"
end
