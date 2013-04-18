class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.string :title
      t.text :body
      t.references :forum
      t.references :user

      t.timestamps
    end
    add_index :forum_threads, :forum_id
    add_index :forum_threads, :user_id
  end
end
