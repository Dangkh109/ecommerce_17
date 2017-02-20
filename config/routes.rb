Rails.application.routes.draw do

  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :category, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end
  get "*path", to: "static_pages#home"
end
