Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: :oauth_callbacks
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'application#index'

  # get '/users/auth/discourse/callback' => 'oauth#discourse'

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index, :show, :create]
      resources :users, only: [] do
        get :me, on: :collection
        delete :signout, on: :collection
      end
    end
  end
end
