class CommentsController < ApplicationController
	def create
		puts "parametre post id"
		puts params[:post_id]
		@post = Post.find(params[:post_id])
		puts "parametres controller"
		puts params[:comment]
		@comment = @post.comments.create("author" => params[:author], "body" => params[:body])
		redirect_to post_path(@post), notice: 'Comment was successfully created.'
	end
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post), notice: 'Comment was successfully destroyed.'
	end
end

