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
class CreateForumForums < ActiveRecord::Migration
  def change
    create_table :forum_forums do |t|
      t.string :name
      t.text :description
      t.references :category
      t.integer :list_order

      t.timestamps
    end
    add_index :forum_forums, :category_id
  end
end
