# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :users, only: %i[show index]
  resources :friend_requests, only: %i[index new create destroy]
  resources :friendships, only: %i[index new create destroy]

  resources :posts do
    resources :likes, only: %i[create destroy]
    resources :comments
  end
end
