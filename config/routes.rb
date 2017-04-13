Rails.application.routes.draw do
  use_doorkeeper do
    controllers applications: 'oauth/applications'
  end

  devise_for :users

  get 'feeds/newsletter', controller: :feeds, action: :newsletter

  resources :bands do
    resources :posts, on: :member, controller: :band_posts
    get :player_code, on: :member
    post :refetch_photo, on: :member
  end

  resources :posts do
    get 'new/text', action: :new_form, type: :text, as: :new_text, on: :collection
    get 'new/link', action: :new_form, type: :link, as: :new_link, on: :collection
  end

  resources :venues
  resources :events
  resources :teams do
    get 'edit/users', controller: :teams, action: :edit_users, on: :member, as: :edit_users
    post 'edit/users', controller: :teams, action: :invite_user, on: :member, as: :invite_user
    delete 'edit/users/:team_user_id', controller: :teams, action: :remove_user, on: :member, as: :remove_user
    resources :events, on: :member, controller: :team_events
  end

  resources :embeds, only: [] do
    get :horizontal, on: :collection
  end

  get '/@:username', to: 'users#show', as: :user
  get '/:id/:slug', to: 'events#show', as: :event_slugged, slugged: true

  get :search, controller: :search, action: :index
  get :about, to: 'application#about'

  post '/change_locale/:locale', to: 'application#change_locale', as: :change_locale

  get :check, controller: :application
  root to: 'events#index'
end
