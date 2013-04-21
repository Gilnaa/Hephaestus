class RenameUserColumnOnThreadAndPost < ActiveRecord::Migration
  def change
    rename_column :forum_threads, :user_id, :author_id
    rename_column :forum_comments, :user_id, :author_id
  end
end
