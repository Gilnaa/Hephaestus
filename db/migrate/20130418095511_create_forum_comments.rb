class CreateForumComments < ActiveRecord::Migration
  def change
    create_table :forum_comments do |t|
      t.text :body
      t.references :thread
      t.references :user

      t.timestamps
    end
    add_index :forum_comments, :thread_id
    add_index :forum_comments, :user_id
  end
end
