class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category'
  attr_accessible :description, :name
  
  has_many :children, class_name: 'Category', dependent: :destroy
  has_many :forums, dependent: :destroy
  
  validates :name, presence: true
  
  def moderators
    
  end
  def is_moderator? (user)
    # TODO
  end
  def has_parent?
    not self.parent.nil?
  end
end
