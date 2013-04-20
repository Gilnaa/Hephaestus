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
  belongs_to :forum
  belongs_to :role
  attr_accessible :can_comment, :can_poll, :can_post, :can_view
  
  validates_uniqueness_of :role, :scope => :forum
  def self.get_default
    ForumRoleMatch.where('role = ? AND forum = ?', nil, nil)
  end
end
