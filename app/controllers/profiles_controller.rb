class ProfilesController < ApplicationController

  def show
    # @posts = Post.all
      @posts = User.find_by(username: params[:username]).posts

  end
end
