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
