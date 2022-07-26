Rails.application.routes.draw do
  devise_for :accounts
  root to: "public#homepage"
  get 'my_account', to: 'accounts#my_account'
  get 'my_friends', to: 'accounts#my_friends'
  get 'search_friends', to: 'accounts#search'
  resources :friendships, only: [:create, :destroy]
  resources :accounts, only: [:show]
end
