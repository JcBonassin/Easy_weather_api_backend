Rails.application.routes.draw do
  
  root to: "home#index"

  post '/login',    to: 'sessions#create'
  post '/logout',   to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?' 
  
  resources :users, only: [:create, :show, :index] 
 
  resources :locations


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
