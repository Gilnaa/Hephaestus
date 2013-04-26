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
class Role < ActiveRecord::Base
  BLACK = "#000000"
  attr_accessible :adjective, :color, :groupname, :is_admin, :is_moderator, :name

  has_many :forum_role_matches, dependent: :destroy 
  has_many :users

  before_save do |role|
    role.is_admin ||= false
    role.is_moderator ||= false
    
    role.is_moderator = true if role.is_admin
    role.color ||= BLACK
  end
end
