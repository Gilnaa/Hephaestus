class CreateCategoryModerations < ActiveRecord::Migration
  def change
    create_table :category_moderations do |t|
      t.references :category
      t.references :moderator

      t.timestamps
    end
    add_index :category_moderations, :category_id
    add_index :category_moderations, :moderator_id
  end
end
