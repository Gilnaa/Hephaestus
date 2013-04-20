#-------------------------------------------------------------------------------
# Copyright (c) 2013 Gilad Naaman.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0
# which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/gpl.html
# 
# Contributors:
#     Gilad Naaman - initial API and implementation
#-------------------------------------------------------------------------------
Hephaestus::Application.routes.draw do
  root :to => 'home#index'
  
  resources :forum_threads
  resources :forum_thread
  
  resources :users
  resources :user
  match '/users/list/' => redirect("/users/list/0")  
  match '/users/list/:page_number' => 'users#index'
  match '/signup/' => 'users#new'
  
  resources :sessions, only: [:new, :create, :destroy]
  match '/login/' => 'sessions#new'
  match '/logout/' => 'sessions#destroy', via: :delete
  
  match '/forum/' => 'forum::home#index', as: :forums
  match '/forum/cat/:id' => 'forum::home#index', as: :forums_category
  match '/forum/view/:id' => 'forum::home#view', as: :forum_view
end
