Fcchelsea::Application.routes.draw do
  root 'main#home'

  get '/auth/:provider', :to => 'sessions#auth', as: 'auth'
  match 'auth/:provider/callback', :to => 'sessions#create', :via => [:get, :post]
  delete '/signout', :to => 'sessions#destroy'

  resources :users
  resources :posts do
    resources :comments, :only => [:create, :update, :destroy]
  end
end
