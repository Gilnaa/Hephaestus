class Forum::Category < ActiveRecord::Base
  attr_accessible :description, :list_order, :name
  
  has_many :forums, dependent: :destroy
  has_many :category_moderations, dependent: :destroy
end
