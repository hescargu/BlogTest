require 'spec_helper'

describe CommentsController do
	describe "create" do
		before(:each) do
			@posts = [stub_model(Post,:title => "sujet1", :body => "rfhergzb"), 
				  stub_model(Post,:title => "sujet3", :body => "rfhevfevfrgzb"), 
				  stub_model(Post,:title => "sujet4", :body => "rregagfhergzb")]
			@post = @posts[0]
			@new_comment = {"author" => "new auteur", "body" => "new commentaire"}
			@comments = [stub_model(Comment, :author => "auteur", :body => "commentaire", :post_id => @post.id)]
			Post.stub(:find) { @post }
			Post.stub(:comments) { true }
			Comment.stub(:create) { @commentcreated }
			visit post_path(@post)
		end
		it "create doit retourner un comment" do
			Post.should_receive(:find).and_return(@post)
			@post.should_receive(:comments).and_return(@comments)
			@comments.should_receive(:create).with(@new_comment["comment"]).and_return(@commentcreated)
			post :create,  @new_comment
			response.should redirect_to(post_path(@post))
		end
	end
	describe "destroy" do
		before(:each) do
			@posts = [stub_model(Post,:title => "sujet1", :body => "rfhergzb"), 
				  stub_model(Post,:title => "sujet3", :body => "rfhevfevfrgzb"), 
				  stub_model(Post,:title => "sujet4", :body => "rregagfhergzb")]
			@post = @posts[0]
			@comment = stub_model(Comment, :author => "auteur", :body => "commentaire", :post_id => @post.id)
			@comments = [@comment]
			Post.stub(:find) { @post }
			Post.stub(:comments) { true }
			Comment.stub(:find) { @comment }
			Comment.stub(:destroy) { true }
			visit post_path(@post)
		end
		it "delete doit avoir supprimer un comment" do
			Post.should_receive(:find).and_return(@post)
			@post.should_receive(:comments).and_return(@comments)
			@comments.should_receive(:destroy).with(@new_comment["comment"]).and_return(@commentcreated)
			post :create,  @new_comment
			response.should redirect_to(post_path(@post))
		end
	end
end




