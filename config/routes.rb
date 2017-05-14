Rails.application.routes.draw do

  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root "foods#index"
    devise_for :users, skip: :omniauth_callbacks

    resources :foods
    resources :comments
    resources :likes, only: [:create, :destroy]
    resources :relationships
    resources :users, only: [:show, :edit, :update]
  end
  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root
end
