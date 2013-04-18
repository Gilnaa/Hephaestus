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
