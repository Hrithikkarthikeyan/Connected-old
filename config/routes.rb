Rails.application.routes.draw do
  devise_for :accounts
  root to: "posts#index"
  get 'my_friends', to: 'accounts#my_friends'
  get 'search_friends', to: 'accounts#search'
  get 'view_connections', to: 'accounts#view_connections'
  get 'viewed_my_account', to: 'views#index'
  
  resources :friendships, only: [:create, :destroy]
  resources :accounts, only: [:show, :destroy]
  resources :posts, only: [:new, :create, :show, :index, :destroy]
  resources :likes, shallow: true
  resources :comments, only: [:index, :create, :destroy], shallow: true
  resources :requests
  resources :views
end
