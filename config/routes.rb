Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  resources :users, only: %i[show index]
  resources :friend_requests, only: %i[new create]

  resources :posts
end
