class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.references :category

      t.timestamps
    end
    add_index :forums, :category_id
  end
end
