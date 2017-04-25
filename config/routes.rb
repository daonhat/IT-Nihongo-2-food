Rails.application.routes.draw do
  root "foods#index"
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}

  resources :foods
  resources :comments
  resources :likes
  resources :relationships
  resources :users, only: [:show, :edit, :update]
end
