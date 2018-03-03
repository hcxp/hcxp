Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: {
    omniauth_callbacks: :oauth_callbacks
  }

  root to: 'application#index'

  # get '/users/auth/discourse/callback' => 'oauth#discourse'

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :show, :create] do
        post :ping_view, on: :member
        resources :bands, on: :member, only: [:index], controller: :event_bands
      end

      resources :users, only: [] do
        get :me, on: :collection
        delete :signout, on: :collection
      end
    end
  end
end
