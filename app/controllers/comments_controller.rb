class CommentsController < ApplicationController
	def new
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new
		respond_to do |format|
	      		format.html
	      		format.js
		end
	end
	def create
		puts "parametre post id"
		puts params[:post_id]
		@post = Post.find(params[:post_id])
		puts "parametres controller"
		puts params[:comment]
		@comment = @post.comments.create("author" => params[:author], "body" => params[:body])
		respond_to do |format|
			format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
			format.js
		end
	end
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
	    	respond_to do |format|
	      		format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.'}
	      		format.js
		end
		
	end
end

