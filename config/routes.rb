Balltracker::Application.routes.draw do
  root 'main#home'

  get '/auth/:provider', :to => 'sessions#auth'
  match '/auth/:provider/callback', :to => 'sessions#auth_success', :via => [:get, :post]
  get '/auth/failure', :to => 'sessions#auth_failure'
  delete '/signout', :to => 'sessions#destroy'

  resources :users
  resources :posts do
    resources :comments, :only => [:index, :create, :update, :destroy]
  end

  resources :teams, :only => [:index, :create, :update, :destroy]

  resources :seasons do
    collection do
      get 'last'
    end

    resources :rounds
  end

  resources :rounds, :except => [:new, :create] do
    resources :games
  end

  resources :games
end
