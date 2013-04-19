module UsersHelper
  def get_gravatar_for(user, size=nil, css_class=nil)
    gid = Digest::MD5::hexdigest user.email.downcase
    g_url = "https://secure.gravatar.com/avatar/#{gid}"
    image_tag( g_url, alt: user.username, size: "#{size}x#{size}", class: "gravatar " << (css_class || "")) 
  end
end