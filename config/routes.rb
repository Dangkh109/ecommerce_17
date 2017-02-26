Rails.application.routes.draw do

  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  root "static_pages#home"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :category, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:index, :create, :destroy]
  resources :view, only: [:index]
  namespace :users do
    resources :orders, only: [:create]
  end
  get "*path", to: "static_pages#home"
end
