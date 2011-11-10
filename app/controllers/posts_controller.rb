class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
	@posts = Post.all
  end
end
