class CommentsController < ApplicationController
  before_action :set_post
  before_action :logged_in_user
  def index
    @comments = @post.comments.order("created_at DESC")

    respond_to do |format|
      format.html
      format.js
      # format.html { render :layout => !request.xhr? }

    end
  end
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      (@post.users.uniq - [current_user]).each do |user|
        Notification.create(recipient:user,actor:current_user,action:"commented",notifiable: @comment)
      end
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js
      end
    else
      flash[:alert] = "Check the comment form, something went wrong."
      render posts_path
    end
  end
  def destroy
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
    # flash[:success] = "Comment deleted :("
    # redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
