class AddTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :forum
      t.references :author
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :topics, :forum_id
    add_index :topics, :author_id
  end
end
