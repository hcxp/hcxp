Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  devise_for :users

  resources :bands do
    resources :posts, on: :member, controller: :band_posts
  end

  resources :posts, only: [:index, :show]
  resources :venues
  resources :events
  resources :teams do
    get 'edit/users', controller: :teams, action: :edit_users, on: :member, as: :edit_users
    post 'edit/users', controller: :teams, action: :invite_user, on: :member, as: :invite_user
    delete 'edit/users/:team_user_id', controller: :teams, action: :remove_user, on: :member, as: :remove_user
    resources :events, on: :member, controller: :team_events
  end

  get '/@:username', to: 'users#show', as: :user

  get :search, controller: :search, action: :index
  get :about, to: 'application#about'

  post '/change_locale/:locale', to: 'application#change_locale', as: :change_locale

  root to: 'events#index'
end
