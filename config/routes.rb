Rails.application.routes.draw do
  resources :tweets, except: :index
  root "tweets#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
