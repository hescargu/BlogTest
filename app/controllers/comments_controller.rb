class CommentsController < ApplicationController
	def create
		puts params
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment])
		redirect_to post_path(@post), notice: 'Comment was successfully created.'
	end
	def destroy
		puts params
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post), notice: 'Comment was successfully created.'
	end
end

