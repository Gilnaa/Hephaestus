class Topic < ActiveRecord::Base
  belongs_to :forum, class_name: 'Forum::Forum'
  belongs_to :author, class_name: 'User'
  attr_accessible :body, :title
  
  validates :body, presence: true, length: {minimum: 3}
  validates :title, presence: true, length: {minimum: 3,maximum: 140}
    
  has_many :comments, dependent: :destroy

end