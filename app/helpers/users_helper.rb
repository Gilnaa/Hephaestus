module UsersHelper
  def get_gravatar_for(user, width=nil, height=nil)
    gid = Digest::MD5::hexdigest user.email.downcase
    g_url = "https://secure.gravatar.com/avatar/#{gid}"
    image_tag g_url, alt: user.username, size: "#{width}x#{height || width}", class: "gravatar" 
  end
end