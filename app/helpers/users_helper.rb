module UsersHelper
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")

  end
  def get_activity_trackable_content activity
    trackable_type = activity.trackable_type
    @trackable = trackable_type.downcase
  end
end
