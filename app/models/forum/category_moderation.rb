class Forum::CategoryModeration < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  # attr_accessible :title, :body
end
