class ProfilesController < ApplicationController
  before_action :logged_in_user,only:[:edit,:update]
  before_action :owned_profile, only: [:edit, :update]
  # before_action :find_user
  def show
    if User.find_by(username: params[:username])
      @posts = User.find_by(username: params[:username]).posts.order('created_at DESC')
      @user = User.find_by(username: params[:username])

    else
      flash[:alert] = 'Not have that user!'
      redirect_to posts_path
    end


  end
  def edit
    @user = User.find_by(username: params[:username])
  end
  def update
    @user = User.find_by(username: params[:username])
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.username)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end
  private

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end
  def find_user
    params.require(:user).permit(:username)
  end
  def owned_profile
    @user = User.find_by(username: params[:username])
    unless current_user == @user
      flash[:alert] = "That profile doesn't belong to you!"
      redirect_to root_path
    end
  end

end
