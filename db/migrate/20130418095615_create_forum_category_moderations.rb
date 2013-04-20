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
class CreateForumCategoryModerations < ActiveRecord::Migration
  def change
    create_table :forum_category_moderations do |t|
      t.references :category
      t.references :user

      t.timestamps
    end
    add_index :forum_category_moderations, :category_id
    add_index :forum_category_moderations, :user_id
  end
end
