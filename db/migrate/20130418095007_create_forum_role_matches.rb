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
class CreateForumRoleMatches < ActiveRecord::Migration
  def change
    create_table :forum_role_matches do |t|
      t.references :forum
      t.references :role
      t.boolean :can_view
      t.boolean :can_post
      t.boolean :can_comment
      t.boolean :can_poll

      t.timestamps
    end
    add_index :forum_role_matches, :forum_id
    add_index :forum_role_matches, :role_id
  end
end
