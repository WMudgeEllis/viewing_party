Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :users, only: [:create, :new, :show]
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  get '/registration', to: 'users#new'
  get '/dashboard', to:'users#show'
  post '/friendships', to: 'friendships#create'

  get '/discover', to: 'discovers#show'

  resources :movies, only: [:index, :show]
  resources :showings, only: [:new, :create]
end
