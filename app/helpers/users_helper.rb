module UsersHelper
  def get_gravatar_for(user)
    gid = Digest::MD5::hexdigest user.email.downcase
    g_url = "https://secure.gravatar.com/avatar/#{gid}"
    image_tag g_url, alt: user.username, class: "gravatar" 
  end
end