Rails.application.routes.draw do
  get 'sessions/login'
  get 'sessions/logout'
        root "articles#index"

        get "login", to: "sessions#new"
        post "login", to: "sessions#login"

        resources :users
        resources :articles do
                resources :comments
        end
end
