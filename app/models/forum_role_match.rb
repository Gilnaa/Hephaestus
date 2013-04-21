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
class ForumRoleMatch < ActiveRecord::Base
  belongs_to :forum, class_name: 'Forum::Forum'
  belongs_to :role
  attr_accessible :can_comment, :can_poll, :can_post, :can_view
  
  
  def self.get_default
    default = ForumRoleMatch.where('role_id = ? AND forum_id = ?', nil, nil).first
    if not default
      default = self.create do |m|
        m.can_comment = m.can_post = m.can_view = true
        m.can_poll = false
        m.forum_id = nil
        m.role_id = nil
      end
    end
    default
  end
end
