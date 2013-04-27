class RenameReferencesOnModerationModels < ActiveRecord::Migration
  def change
    remove_index :forum_moderations, name: :index_forum_moderations_on_forum_id
    remove_index :forum_moderations, name: :index_forum_moderations_on_moderator_id_and_forum_id
    rename_column :forum_moderations, :forum_id, :moderated_forum_id
    add_index :forum_moderations, :moderated_forum_id
    add_index :forum_moderations, [:moderator_id, :moderated_forum_id]
    
    remove_index :category_moderations, name: :index_category_moderations_on_moderator_id_and_category_id
    rename_column :category_moderations, :category_id, :moderated_category_id
    add_index :category_moderations, :moderated_category_id
    add_index :category_moderations, [:moderator_id, :moderated_category_id], 
                                    name: 'category_moderation_moderator_moderated_index'
  end
end
