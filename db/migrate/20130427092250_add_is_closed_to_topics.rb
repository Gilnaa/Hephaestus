class AddIsClosedToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :is_closed, :boolean
  end
end
