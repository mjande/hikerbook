Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  resources :users, only: %i[show index]
  resources :friend_requests, only: %i[index new create destroy]
  resources :friendships, only: %i[index new create destroy]

  resources :posts do
    resources :likes, only: %i[create destroy]
  end
end
