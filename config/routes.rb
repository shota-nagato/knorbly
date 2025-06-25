Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resources :passwords, param: :token

  get "/login", to: "sessions#new"

  resources :component_styles, only: %i[ index ]

  # ログイン中のユーザー用のダッシュボード
  get "/dashboard", to: "dashboard#index", as: :dashboard

  # ログイン状態に応じて適切にルーティング
  # StaticControllerで認証状態をチェックし、ログイン済みの場合はdashboard_pathにリダイレクト
  root "static#index"
end
