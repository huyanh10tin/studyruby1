module PostsHelper
  # save or unsave
  def text_save(post)
    if current_user.saved? post
      "unsave"
    else
      "save"
    end
  end
  # check saved post
  def save_or_unsave_path(post)
    if current_user.saved? post
      unsave_post_path(post.id)
    else
      save_post_path(post.id)
    end
  end
  def saved_post post
    return 'glyphicon-star' if current_user.saved? post
    'glyphicon-star-empty'
  end

  #check liked post
  def liked_post(post)
    return 'glyphicon-heart' if current_user.voted_for? post
    'glyphicon-heart-empty'
  end

  def like_or_unlike_path(post)
    if current_user.voted_for? post
      unlike_post_path(post.id)
    else
      like_post_path(post.id)
    end
  end
  def display_likes(post)
    votes = post.votes_for.up
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end

  def count_likers(votes)
    vote_count = votes.count
    vote_count.to_s + ' likes'
  end
  def list_likers(post)
    votes = post.votes_for.up
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.username,
                                profile_path(voter.username),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end
  def linked_users(caption)
    caption.gsub /@([\w]+)/ do |match|
      link_to match,profile_path($1)
    end.html_safe
  end
  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
