Rails.application.routes.draw do
  devise_for :users

  resources :bands
  resources :venues
  resources :events

  get '/@:username', to: 'users#show', as: :user

  get :search, controller: :search, action: :index
  get :about, to: 'application#about'

  root to: 'events#index'
end
