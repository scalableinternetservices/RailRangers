Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
   resources :users, only: [:new, :create]
   resources :posts#, except: :index
   resources :comments
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
   root 'sessions#welcome'
   get 'posts', to: 'posts#index'
   get 'authorized', to: 'sessions#page_requires_login'
end
