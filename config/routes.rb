Rails.application.routes.draw do
  # get 'tweets/new'

  # get 'tweets/create'

  # get 'sessions/destroy'

  # get 'sessions/new'

  # get 'sessions/create'

  # get 'sessions/failure'

 root to: "home#index"



 # get '/auth/:provider/callback', :to => 'sessions#create'
 # get 'auth/failure', :to => redirect('/')

 # get 'signout', :to => 'sessions#destroy', as: 'signout'
 # resources :tweets, only: [:new, :create]
 # resources :sessions, only: [:create, :destroy]
 # resource :home, only: [:show]
 post 'tweets/get_tweets', :to => 'tweets#get_tweets'
 get 'tweets/load_tweets', :to => 'tweets#load_tweets'
end
