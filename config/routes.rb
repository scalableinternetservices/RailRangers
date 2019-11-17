Rails.application.routes.draw do
   resources :users, only: [:new, :create]
   resources :posts#, except: :index
   resources :comments
   resources :requests
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
   root 'sessions#welcome'
   get 'posts', to: 'posts#index'
   get 'authorized', to: 'sessions#page_requires_login'
end
