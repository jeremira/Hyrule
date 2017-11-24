Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
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
  post "/charge" => "gestions#charge", :as => :create_charge


  get  'mappath', to: 'livrets#mappath'
  get  'preview', to: 'livrets#preview'
  root 'static#index'

  end
