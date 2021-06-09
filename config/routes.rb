Rails.application.routes.draw do
        root "home#index"
        
        get "signup", to: "users#new"
        get "login", to: "sessions#new"
        get "logout", to: "sessions#logout"
        post "login", to: "sessions#login"

        resources :users do
                resources :articles do
                        resources :comments
                end
        end
end
