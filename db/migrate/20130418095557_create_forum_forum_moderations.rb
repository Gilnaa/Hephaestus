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
class CreateForumForumModerations < ActiveRecord::Migration
  def change
    create_table :forum_forum_moderations do |t|
      t.references :forum
      t.references :user

      t.timestamps
    end
    add_index :forum_forum_moderations, :forum_id
    add_index :forum_forum_moderations, :user_id
  end
end
