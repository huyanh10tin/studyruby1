class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers,:saved]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  def saved
    @saved = current_user.save_posts
  end
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
    redirect_to root_url and return unless @user.activated?
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Deleted User #{@user.name}"
      redirect_to users_url
    end
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else

      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update Success"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:username, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
