class CreateForumModerations < ActiveRecord::Migration
  def change
    create_table :forum_moderations do |t|
      t.references :forum
      t.references :moderator

      t.timestamps
    end
    add_index :forum_moderations, :forum_id
    add_index :forum_moderations, :moderator_id
  end
end
