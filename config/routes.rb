Rails.application.routes.draw do
        root "articles#index"

        resources :users
        resources :articles do
                resources :comments
              end
end
