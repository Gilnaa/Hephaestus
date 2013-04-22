class AddForumAndUserAsIndexToForumModerations < ActiveRecord::Migration
  def change
    add_index :forum_forum_moderations, :user_id
    add_index :forum_forum_moderations, :forum_id
    
    add_index :forum_category_moderations, :user_id
    add_index :forum_category_moderations, :category_id
  end
end
