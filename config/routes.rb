Hephaestus::Application.routes.draw do
  root :to => 'home#index'
  
  resources :users
  match '/users/list/' => redirect("/users/list/0")  
  match '/users/list/:page_number' => 'users#index'
  match '/signup/' => 'users#new'
  
  resources :sessions, only: [:new, :create, :destroy]
  match '/login/' => 'sessions#new'
  match '/logout/' => 'sessions#destroy', via: :delete
end
