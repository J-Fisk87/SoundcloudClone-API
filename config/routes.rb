Rails.application.routes.draw do
  resources :userfollowers
  resources :tracks
  resources :users, only: [:create, :show]

  # Sessions routes
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'
  


  # Users routes
  get '/api/users/:id', to: 'users#user'
  put 'api/users/:id/follow_user/:follower_id', to: 'users#follow_user'
  put 'api/users/:id/unfollow_user/:follower_id', to: 'users#unfollow_user'


  # Tracks routes
  post '/api/tracks/new', to: 'tracks#create'
  get '/api/tracks/:id', to: 'tracks#track'



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
