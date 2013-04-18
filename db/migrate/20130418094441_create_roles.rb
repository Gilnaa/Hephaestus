class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :groupname
      t.string :adjective
      t.boolean :is_admin
      t.boolean :is_moderator
      t.string :color

      t.timestamps
    end
  end
end
