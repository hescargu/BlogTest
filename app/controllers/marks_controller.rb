class MarksController < ApplicationController
	def new
		@post = Post.find(params[:post_id])
		@mark = @post.marks.new
		respond_to do |format|
	      		format.html 
			format.js
		end
	end
	def create
		@post = Post.find(params[:post_id])
		@mark = @post.marks.create("value" => params[:value], "post_id" => params[:post_id])
		$total = 0;
		$nbMarks = 0;
		@post.marks.each do |mark|
			$total = $total + mark.value
			$nbMarks = $nbMarks + 1
		end
		$note = ($total.to_f/$nbMarks.to_f)
		@post.update_attribute(:note, $note)
		respond_to do |format|
			format.html { redirect_to post_path(@post), notice: 'Mark was successfully added.' }
		end
	end
end

