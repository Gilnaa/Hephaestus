#-------------------------------------------------------------------------------
# Copyright (c) 2013 Gilad Naaman.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the GNU Public License v3.0
# which accompanies this distribution, and is available at
# http://www.gnu.org/licenses/gpl.html
# 
# Contributors:
#     Gilad Naaman - initial API and implementation
#-------------------------------------------------------------------------------
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :created_at
  attr_accessible :first_name, :last_name, :signature, :username

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true

  belongs_to :role
  
  # Forum related associations.
  has_many :topics, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :forum_moderations, dependent: :destroy, foreign_key: 'moderator_id'
  has_many :category_moderations, dependent: :destroy, foreign_key: 'moderator_id'
  has_many :moderated_forums, through: :forum_moderations, source: 'moderated_forum'
  has_many :moderated_categories, through: :category_moderations, source: 'moderated_category'
  
  before_save do |user|
    user.username.downcase!
    user.email.downcase!

    # TODO: Replace with something more reasonable
    # Maybe an 'is_default' column in `Role`
    # Currently. Role #3 is regulars.
    user.role ||= Role.find(3)
    
    user.remember_token = SecureRandom.urlsafe_base64
  end

  ######
  public
  ######
    def is_admin?
      self.role.is_admin
    end
    def is_moderator?
      self.role.is_moderator
    end
    def can_moderate_forum?(forum)
      # If the user is an admin, he will automagically be able to moderate the forum.
      return true if self.is_admin?
      
      # If the user is not a moderator, he won't be able to moderate the forum,
      # even if there is a record of moderation.
      return false unless self.is_moderator?
  
      # The user will be able to moderate the forum if he is a moderator
      # of the specific forum or of the category he's in.
      category = forum.category
      f_mod = self.forum_moderations.find_by_forum_id(forum.id)
      c_mod = self.category_moderations.find_by_category_id(category.id)
      (f_mod or c_mod)
    end
  
    def can_view_forum?(forum)
      forum.get_forum_rules(@role).can_view
    end
  
    def can_post_in_forum?(forum)
      forum.get_forum_rules(@role).can_post
    end
  
    def can_post_poll_in_forum?(forum)
      forum.get_forum_rules(@role).can_poll
    end
  
    def can_comment_in_topic?(topic)
      if topic.is_closed?
        can_moderate_forum? topic.forum
      else
        topic.forum.get_forum_rules(@role).can_comment
      end
    end
end
