class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy, :like, :unlike, :save, :unsave]
  before_action :logged_in_user, only: [:create, :destroy, :new]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def save
    SavePost.create(post_id: @post.id, user_id: current_user.id)
  end

  def unsave
    if @save = SavePost.where("user_id = ? AND post_id = ?", current_user.id, @post.id)
      @save.destroy_all
    end
  end

  def index
    @posts = Post.all.order('created_at DESC').page(params[:page]).per_page(3)
    # @posts = Post.all.order('created_at DESC').paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js

      format.json { render json: @projects }
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      @post.create_activity :create, owner: current_user
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def show

  end

  def destroy
    @post.create_activity :destroy, owner: current_user
    @post.destroy
    
    flash[:success] = "Your post has been deleted!"

    redirect_to posts_path
  end

  def edit

  end

  def like
    if @post.liked_by current_user
      (@post.users.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "liked", notifiable: @post)
      end
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  def unlike
    if @post.unliked_by current_user
      (@post.users.uniq - [current_user]).each do |user|
        Notification.create(recipient: user, actor: current_user, action: "unliked", notifiable: @post)
      end
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed.  Please check the form."
      render :edit
    end
  end

  private
  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
