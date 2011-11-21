class PostsController < ApplicationController
  # GET /posts
  def index
	@posts = Post.all
  end
  # GET /posts/:id
  def show
  	@post = Post.find(params[:id])
  end
  # GET /posts/:id/edit
  def edit
	@post = Post.find(params[:id])
  end
  # GET posts/new
  def new
	@post = Post.new
  end
  def create
   	@post = Post.create(params[:post])
	redirect_to posts_path, notice: 'Post was successfully created.'
  end
end
