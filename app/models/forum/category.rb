class Forum::Category < ActiveRecord::Base
  attr_accessible :description, :list_order, :name
  
  has_many :forums
end
