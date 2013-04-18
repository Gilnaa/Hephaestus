# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130418111020) do

  create_table "forum_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "list_order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "forum_category_moderations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forum_category_moderations", ["category_id"], :name => "index_forum_category_moderations_on_category_id"
  add_index "forum_category_moderations", ["user_id"], :name => "index_forum_category_moderations_on_user_id"

  create_table "forum_comments", :force => true do |t|
    t.text     "body"
    t.integer  "thread_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forum_comments", ["thread_id"], :name => "index_forum_comments_on_thread_id"
  add_index "forum_comments", ["user_id"], :name => "index_forum_comments_on_user_id"

  create_table "forum_forum_moderations", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forum_forum_moderations", ["forum_id"], :name => "index_forum_forum_moderations_on_forum_id"
  add_index "forum_forum_moderations", ["user_id"], :name => "index_forum_forum_moderations_on_user_id"

  create_table "forum_forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "list_order"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forum_forums", ["category_id"], :name => "index_forum_forums_on_category_id"

  create_table "forum_role_matches", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "role_id"
    t.boolean  "can_view"
    t.boolean  "can_post"
    t.boolean  "can_comment"
    t.boolean  "can_poll"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forum_role_matches", ["forum_id"], :name => "index_forum_role_matches_on_forum_id"
  add_index "forum_role_matches", ["role_id"], :name => "index_forum_role_matches_on_role_id"

  create_table "forum_threads", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forum_threads", ["forum_id"], :name => "index_forum_threads_on_forum_id"
  add_index "forum_threads", ["user_id"], :name => "index_forum_threads_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "groupname"
    t.string   "adjective"
    t.boolean  "is_admin"
    t.boolean  "is_moderator"
    t.string   "color"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.text     "signature"
    t.integer  "role_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
