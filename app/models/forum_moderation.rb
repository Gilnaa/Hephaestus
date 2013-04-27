class ForumModeration < ActiveRecord::Base
  belongs_to :moderated_forum, class_name: 'Forum'
  belongs_to :moderator, class_name: 'User'
  
  validates_uniqueness_of :moderator_id, :scope => [:moderated_forum_id]
end
