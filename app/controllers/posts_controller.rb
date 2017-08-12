class PostsController < ApplicationController
	before_action :set_post,only: [:edit,:show,:update,:destroy]
	before_action :logged_in_user, only: [:create, :destroy,:new]
	before_action :owned_post, only: [:edit, :update, :destroy]
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
		if @post = current_user.posts.create(post_params)
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

		@post.destroy
		redirect_to posts_path
	end
	def edit

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
