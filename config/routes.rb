Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  resources :users
  post '/login', to: 'sessions#create'
  get '/registration', to: 'users#new'
  get '/dashboard', to:'users#show'
end
