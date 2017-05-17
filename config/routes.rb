Rails.application.routes.draw do

  resources :activities
  resources :themes
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :accounts

  resources :trips do
    resources :days
  end

  #resource for stripe payment
  resources :charges

  root 'trips#index'
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
