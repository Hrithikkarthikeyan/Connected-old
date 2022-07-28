Rails.application.routes.draw do
  devise_for :accounts
  root to: "posts#index"
  get 'my_account', to: 'accounts#my_account'
  get 'my_friends', to: 'accounts#my_friends'
  get 'search_friends', to: 'accounts#search'
  
  
  resources :friendships, only: [:create, :destroy]
  resources :accounts, only: [:show]
  resources :posts, only: [:new, :create, :show, :index, :destroy]
  resources :likes, shallow: true
  resources :comments, only: [:index, :create, :destroy], shallow: true
end
