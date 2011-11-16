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
end
