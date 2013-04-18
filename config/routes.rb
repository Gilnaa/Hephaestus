Hephaestus::Application.routes.draw do
  root :to => 'home#index'
  
  resources :users
  match '/users/list/' => redirect("/users/list/0")  
  match '/users/list/:page_number' => 'users#index'
  match '/signup/' => 'users#new'
  match '/login/' => 'users#new'
  match '/logout/' => 'users#new'
end
