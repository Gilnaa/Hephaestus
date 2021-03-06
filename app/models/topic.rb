class Topic < ActiveRecord::Base
  belongs_to :forum, class_name: 'Forum'
  belongs_to :author, class_name: 'User'
  attr_accessible :body, :title, :is_closed
  
  validates :body, presence: true, length: {minimum: 3}
  validates :title, presence: true, length: {minimum: 3,maximum: 140}
  
  validates :author_id, presence: true
  validates :forum_id, presence: true
  
  has_many :comments, dependent: :destroy
end
