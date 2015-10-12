Rails.application.routes.draw do
  
  get 'sources/new'

  get 'sources/destroy'

  get 'sources/create'

  get 'sources/new'

  get 'sources/destroy'

  get 'sources/show'

  get 'sources/index'

  # Root is the unauthenticated path
  root 'sessions#unauth'



  # Sessions URL
  get 'sessions/unauth', as: :login
  post 'sessions/login', as: :signin
  delete 'sessions/logout', as: :logout

  # Resourceful routes for posts
  get '/interests', to: 'articles#my_interests', as: 'interests'
  get '/scrape', to: 'articles#scrape', as: 'scrape'
  post '/post/:id/comment', to: 'posts#comment', as: 'comment_on_post'
  resources :users, only: [:create,:new,:update,:destroy,:edit]
  resources :articles

end
