Rails.application.routes.draw do
  resources :contacts
  resources :replies
  resources :comments
  resources :tags

  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'
  delete '/users/:id', to: 'users#destroy'
  put '/users/:id', to: 'users#update'

  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show'
  post '/posts', to: 'posts#create'
  delete '/posts/:id', to: 'posts#destroy'
  put '/posts/:id', to: 'posts#update'
  patch '/posts/:id', to: 'posts#update_views'

  get '/tags', to: 'tags#index'
  get '/tags/:id', to: 'tags#show'
  post '/tags', to: 'tags#create'
  delete '/tags/:id', to: 'tags#destroy'
  put '/tags/:id', to: 'tags#update'

  get '/comments', to: 'comments#index'
  get '/comments/:id', to: 'comments#show'
  post '/comments', to: 'comments#create'
  delete '/comments/:id', to: 'comments#destroy'
  put '/comments/:id', to: 'comments#update'

  get '/replies', to: 'replies#index'
  get '/replies/:id', to: 'replies#show'
  post '/replies', to: 'replies#create'
  delete '/replies/:id', to: 'replies#destroy'
  put '/replies/:id', to: 'replies#update'

  get '/reports', to: 'reports#index'
  get '/reports/:id', to: 'reports#show'
  post '/reports', to: 'reports#create'
  delete '/reports/:id', to: 'reports#destroy'
  put '/reports/:id', to: 'reports#update'

  resources :users, params: :name
  post '/login', to: 'authentication#login'
  post "login/forgot_password", to: "users#forgot"
  post "login/reset_password", to: "users#reset"

  # get '/*a', to: 'application#not_found'
end
