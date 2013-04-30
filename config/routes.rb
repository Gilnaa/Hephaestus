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
  devise_for :users

  NUMERIC = /(0|[1-9][0-9]*)/
  root to: 'home#index'
  
  resources :users, constraints: {:id => NUMERIC}
  match '/users/list/' => 'users#index'
  match '/users/list/:page_number' => 'users#index', page_id: NUMERIC
  match '/signup/' => 'users#new'


  devise_scope :user do
    match '/login/' => "devise/sessions#new"
    match '/logout/' => 'devise/sessions#destroy', via: :delete
  end
  
  
  resources :forums, only: [:index, :show], constraints: {:id => NUMERIC}
  scope '/forums', constraints: {:id => NUMERIC} do
    resources :topics, only: [:show, :new, :create, :edit, :update, :destroy]
    resources :comments, only: [:show, :new, :create, :edit, :update, :destroy]
  end
=begin
  match '/forum/' => 'forum::home#index', as: :forums
  match '/forum/cat/:id' => 'forum::home#index', as: :forums_category
  match '/forum/view/:id' => 'forum::home#view', as: :forum_view
  match '/forum/view/:id/:page_number' => 'forum::home#view', as: :forum_view_page

  match 'forum/thread/:thread_id/' => 'forum/threads#show', as: :forum_thread, thread_id: NUMERIC_MATCH
  match 'forum/thread/:thread_id/:page_number' => 'forum::threads#show', as: :forum_thread_page, thread_id: NUMERIC_MATCH, page_number: NUMERIC_MATCH
  match 'forum/thread/:thread_id/edit' => 'forum::threads#edit', as: :edit_forum_thread, thread_id: NUMERIC_MATCH
  match 'forum/thread/:thread_id/delete' => 'forum::threads#delete', via: :delete, as: :delete_forum_thread, thread_id: NUMERIC_MATCH
  match 'forum/thread/new/:forum_id' => 'forum::threads#new', as: :new_forum_thread, forum_id: NUMERIC_MATCH
  match 'forum/thread/create/' => 'forum/threads#create',  via: :post
  match 'forum/thread/update/' => 'forum/threads#update',  via: :put
  
  match 'forum/thread/:thread_id/comment' => 'forum::threads#new_comment', as: :new_forum_comment, thread_id: NUMERIC_MATCH
  match 'forum/thread/create_comment' => 'forum/threads#create_comment', via: :post
  match 'forum/comment/:comment_id' => 'forum::threads#create_comment', as: :forum_comment, comment_id: NUMERIC_MATCH
=end
end
