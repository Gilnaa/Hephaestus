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
class Forum::Forum < ActiveRecord::Base
  belongs_to :category
  attr_accessible :description, :list_order, :name
  
  has_many :threads, class_name: 'Forum::Thread'
  has_many :topics, class_name: 'Topic'
  has_many :forum_moderations, dependent: :destroy
  
  before_save do |forum|
    # Create default forum rules if not already existent.
    default_forum_rules = ForumRoleMatch.get_default
    if not default_forum_rules
      default_forum_rules = ForumRoleMatch.create do |rule|
        rule.can_view =         true
        rule.can_post =         true
        rule.can_comment =      true
        rule.can_poll =         false
      end
      default_forum_rules.save
    end    
  end
  
  ##
  # This method returns the default rules (+ForumRoleMatch+) for this forum.
  # The return +ForumRoleMatch+ object's role attribute will be +nil+.
  #
  # This method is used when no +ForumRoleMatch+ is find for this forum
  # and a specific role.
  def get_default_rules
    
    rules = ForumRoleMatch.where('forum_id = ? AND role_id = ?', @id, nil).first
    if not rules
      rules = ForumRoleMatch.get_default.dup
      rules.forum = self
      rules.save
    end
    rules
    
  end
  
  ##
  # Returns the +ForumRoleMatch+ for the current forum and for the given role. 
  def get_forum_rules(role)
    rules = ForumRoleMatch.where('role_id = ? AND forum_id = ?', role.object_id, @id).first
    if not rules
      rules = self.get_default_rules.dup
      rules.role = role
      rules.save
    end
    rules
  end
end
