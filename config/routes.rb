Rails.application.routes.draw do
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :accounts
  resources :setup, :only => [:index]
  resources :livrets do
    resources :assets
  end
  resources :themes
  resources :trips do
    resources :days
    resources :gestions, :only => [:update]
  end
  #resource for stripe payment
  resources :charges

  get  'commercial',  to: 'themes#commercial'
  get  'mappath', to: 'livrets#mappath'
  get  'preview', to: 'livrets#preview'
  root 'static#index'

  end
