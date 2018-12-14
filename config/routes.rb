Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #add our register route
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'set', to: 'users#set'

  #task routes
  post 'task/create', to: 'tasks#create'
  post 'task/get', to: 'tasks#get'
  post 'task/complete', to: 'tasks#complete'
  post 'task/hours', to: 'tasks#hours'
end
