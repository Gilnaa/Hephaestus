class AddIndexesToModerationModels < ActiveRecord::Migration
  def change
    add_index :forum_moderations, [:moderator_id, :forum_id]
    
    add_index :category_moderations, [:moderator_id, :category_id]
  end
end
