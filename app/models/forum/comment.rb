class Forum::Comment < ActiveRecord::Base
  belongs_to :thread
  belongs_to :user
  attr_accessible :body
end
