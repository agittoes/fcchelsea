Fcchelsea::Application.routes.draw do
  root 'main#home'

  get '/auth/:provider', :to => 'sessions#auth'
  match '/auth/:provider/callback', :to => 'sessions#auth_success', :via => [:get, :post]
  get '/auth/failure', :to => 'sessions#auth_failure'
  delete '/signout', :to => 'sessions#destroy'

  resources :users
  resources :posts do
    resources :comments, :only => [:index, :create, :update, :destroy]
  end
end
