class ForumModeration < ActiveRecord::Base
  belongs_to :forum
  belongs_to :moderator, class_name: 'User'
  
  validates_uniqueness_of :moderator_id, :scope => [:forum_id]
end
