class CategoryModeration < ActiveRecord::Base
  belongs_to :moderated_category, class_name: 'Category'
  belongs_to :moderator, class_name: 'User'
  
  validates_uniqueness_of :moderator_id, :scope => [:moderated_category_id]
end
