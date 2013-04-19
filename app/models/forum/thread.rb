class Forum::Thread < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  attr_accessible :body, :title
  
  has_many :comments, dependent: :destroy
end
