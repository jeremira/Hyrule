Rails.application.routes.draw do
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :accounts

  resources :themes do
    resources :activities
  end

  resources :trips do
    resources :days
  end

  #resource for stripe payment
  resources :charges

  root 'trips#index'
  end
