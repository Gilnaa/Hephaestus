class CategoryModeration < ActiveRecord::Base
  belongs_to :category
  belongs_to :moderator, class_name: 'User'
  
  validates_uniqueness_of :moderator_id, :scope => [:category_id]
end
