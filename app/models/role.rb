class Role < ActiveRecord::Base
  BLACK = "#000000"
  attr_accessible :adjective, :color, :groupname, :is_admin, :is_moderator, :name

  has_many :forum_role_matches, dependent: :destroy 
  has_many :users

  before_save do |role|
    role.is_moderator = true if role.is_admin
    role.color ||= BLACK
  end
end
