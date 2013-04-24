class Comment < ActiveRecord::Base
  belongs_to :topic
  belongs_to :author, class_name: 'User'
  attr_accessible :body, :title, :created_at
  
  validates :body, presence: true, length: {minimum: 3}
  
  before_save do |comment|
    comment.title ||= "Re: " + comment.topic.title
  end
end
