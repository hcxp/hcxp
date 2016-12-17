Rails.application.routes.draw do
  devise_for :users

  resources :bands
  resources :venues
  resources :events

  get :search, controller: :search, action: :index

  root to: 'events#index'
end
