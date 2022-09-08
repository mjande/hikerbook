Rails.application.routes.draw do
  root 'posts#index'
  
  devise_for :users
  resources :users, only: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :posts
end
