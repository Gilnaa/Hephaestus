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

ActiveRecord::Schema.define(:version => 20130429092706) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "category_moderations", :force => true do |t|
    t.integer  "moderated_category_id"
    t.integer  "moderator_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "category_moderations", ["moderated_category_id"], :name => "index_category_moderations_on_category_id"
  add_index "category_moderations", ["moderated_category_id"], :name => "index_category_moderations_on_moderated_category_id"
  add_index "category_moderations", ["moderator_id", "moderated_category_id"], :name => "category_moderation_moderator_moderated_index"
  add_index "category_moderations", ["moderator_id"], :name => "index_category_moderations_on_moderator_id"

  create_table "comments", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "author_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"
  add_index "comments", ["topic_id"], :name => "index_comments_on_topic_id"

  create_table "forum_category_moderations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forum_category_moderations", ["category_id"], :name => "index_forum_category_moderations_on_category_id"
  add_index "forum_category_moderations", ["user_id"], :name => "index_forum_category_moderations_on_user_id"

  create_table "forum_forum_moderations", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "forum_forum_moderations", ["forum_id"], :name => "index_forum_forum_moderations_on_forum_id"
  add_index "forum_forum_moderations", ["user_id"], :name => "index_forum_forum_moderations_on_user_id"

  create_table "forum_moderations", :force => true do |t|
    t.integer  "moderated_forum_id"
    t.integer  "moderator_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "forum_moderations", ["moderated_forum_id"], :name => "index_forum_moderations_on_moderated_forum_id"
  add_index "forum_moderations", ["moderator_id", "moderated_forum_id"], :name => "index_forum_moderations_on_moderator_id_and_moderated_forum_id"
  add_index "forum_moderations", ["moderator_id"], :name => "index_forum_moderations_on_moderator_id"

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

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forums", ["category_id"], :name => "index_forums_on_category_id"

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
    t.integer  "forum_id"
    t.integer  "author_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_closed"
  end

  add_index "topics", ["author_id"], :name => "index_topics_on_author_id"
  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.text     "signature"
    t.integer  "role_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "remember_token"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
