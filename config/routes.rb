Rails.application.routes.draw do
   resources :users, only: [:show, :new, :create]
   resources :posts#, except: :index
   resources :comments
   resources :requests
   get 'login', to: 'sessions#new'
   get 'user', to: 'users#show'
   get 'users', to: 'users#index'
   post 'requests', to: 'requests#create'
   get 'new_request', to: 'requests#new'
   put 'request', to: 'request#update'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
   root 'sessions#welcome'
   get 'posts', to: 'posts#index'
   get 'authorized', to: 'sessions#page_requires_login'
end
