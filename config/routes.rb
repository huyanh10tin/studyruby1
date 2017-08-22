Rails.application.routes.draw do
  resources :chatrooms do
    resource :chatroom_users
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # get ':username', to: 'profiles#show', as: :profile
  get '/profiles/:username', to: 'profiles#show', as: :profile
  get '/profiles/:username/edit', to: 'profiles#edit', as: :profile_edit
  patch '/profiles/:username/edit', to: 'profiles#update', as: :profile_update
  get 'password_resets/new'

  get 'password_resets/edit'

  # root 'static_pages#home'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do

    member do
      get :following, :followers
    end
    member do
      get 'saved'
    end
  end
  resources :events
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :activities, only: [:index, :create]
  resources :posts do
    collection { post :search, to: 'posts#index' }
    resources :comments
    member do
      get 'save'
    end
    member do
      get 'unsave'
    end
    member do
      get 'like'
    end
    member do
      get 'unlike'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
