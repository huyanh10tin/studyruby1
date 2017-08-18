json.array! @notifications do |notification|
  # json.id notification.id
  # json.unread !notification.read_at?
  #json.template render partial: "notifications/comments/liked",locals:{notification: notification}


  ##{notification.notifiable_type.underscore.pluralize}/#{notification.action}"
  json.recipient notification.recipient
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable do
    if notification.notifiable.is_a?(Post)
      json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase} be #{notification.action}"
    else
      json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    end
  end
  if notification.notifiable.is_a?(Post)
    json.url post_path(notification.notifiable, anchor: dom_id(notification.notifiable))
  else
    json.url post_path(notification.notifiable.post, anchor: dom_id(notification.notifiable))
  end

end