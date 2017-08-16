module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.nil?
      return base_title
    else
      return page_title + " | " + base_title
    end
  end
  def time_ago_in_words(from_time, include_seconds_or_options = {})
    distance_of_time_in_words(from_time, Time.now, include_seconds_or_options)
  end
  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive img-circle profile-image' if user.avatar.exists?
    image_tag 'default-avatar.jpg', id: 'image-preview',
              class: 'img-responsive img-circle profile-image'
  end
end
