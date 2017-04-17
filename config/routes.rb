Rails.application.routes.draw do
  root "foods#index"
  devise_for :users, :controllers => {:registrations => "users/registrations",
    :sessions => "users/sessions"}

  resources :foods
  resources :comments
  resources :likes
  resources :relationships
  resources :users, only: [:show, :edit, :update]
end
