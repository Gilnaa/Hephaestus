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
