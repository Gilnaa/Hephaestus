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
class Forum::Comment < ActiveRecord::Base
  belongs_to :thread
  belongs_to :author, class_name: 'User'
  attr_accessible :body, :created_at
  validates :body, presence: true, length: {minimum: 2}
end
