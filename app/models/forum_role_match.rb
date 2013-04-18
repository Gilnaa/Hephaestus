class ForumRoleMatch < ActiveRecord::Base
  belongs_to :forum
  belongs_to :role
  attr_accessible :can_comment, :can_poll, :can_post, :can_view
  
  validates_uniqueness_of :role, :scope => :forum
  def self.get_default
    ForumRoleMatch.where('role = ? AND forum = ?', nil, nil)
  end
end
