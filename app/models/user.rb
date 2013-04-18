class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  attr_accessible  :password_digest, :password, :password_confirmation
  attr_accessible :email, :first_name, :last_name, :signature, :username
  
  validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  
  belongs_to :role
  has_many :forum_moderations
  has_many :forum_threads
  has_many :forum_comments
  
  before_save do |user|
    user.username.downcase!
    user.email.downcase!
    
    # TODO: Replace with something more reasonable
    # Maybe an 'is_default' column in `Role`
    # Currently. Role #3 is regulars.
    user.role ||= Role.find(3)
  end
  
  def can_moderate_forum?(forum)
    # If the user is an admin, he will automagicaly be able to moderate the forum.
    true if @role.is_admin
    # If the user is not a moderator, he won't be able to moderate the forum,
    # even if there is a record of moderation.
    false if not @role.is_moderator
    
    # The user will be able to moderate the forum if he is a moderator
    # of the specific forum or of the category he's in.
    category = forum.category
    f_mod = ForumModeration.where('user = ?', self).find_by_forum(forum)
    c_mod = CategoryModeration.where('user = ?', self).find_by_category(category)
    (f_mod or c_mode)
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
  def can_comment_in_forum?(forum)
    forum.get_forum_rules(@role).can_comment
  end
end
