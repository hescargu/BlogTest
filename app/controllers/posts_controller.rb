class PostsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  # GET /posts
  def index
	@posts = Post.all
    	respond_to do |format|
      		format.html # index.html.erb
    	end
  end

  # GET /posts/:id
  def show
  	@post = Post.find(params[:id])
    	respond_to do |format|
      		format.html # show.html.erb
    	end
  end


  # GET /posts/:id/edit
  def edit
	@post = Post.find(params[:id])
  end

  # GET posts/new
  def new
	@post = Post.new
	respond_to do |format|
      		format.html
      		format.js
	end
  end

  def create
   	@post = Post.create(params[:post])
	
    respond_to do |format|
      	if @post.save
        	format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
		format.js
      	else
        	format.html { redirect_to new_post_path, notice: 'A problem occured, the post has not been created, try again.' }
		format.js
      	end
    end
  end

  def destroy
	@post = Post.find(params[:id])
	@post.comments.each do |comment|
		comment.destroy
	end
	@post.marks.each do |mark|
		mark.destroy
	end
	@post.destroy
    	respond_to do |format|
      		format.html { redirect_to posts_path, notice: 'Post was successfully deleted.'}
      		format.js
	end
  end
  def update
	@post = Post.find(params[:id])
	@post.marks.each do |mark|
		mark.destroy
	end
	@post.note = 0.0
    	respond_to do |format|
	      	if @post.update_attributes(params[:post])
			format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
	      	else
			format.html { redirect_to edit_post_path(@post), notice: 'A problem occured, try to edit again.'}
	      	end
    	end
	
  end
end
