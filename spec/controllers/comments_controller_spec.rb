require 'spec_helper'

describe CommentsController do
	describe "new" do
		before(:each) do
			@user = User.create(:email => "test@test.com", :password => "password", :password_confirmation => "password")
			@post = stub_model(Post,:title => "sujet", :body => "rfhgpqrvb", :user_id => @user.id, :note => 3.00)
			@comment = stub_model(Comment, :author => "auteur", :body => "commentaire", :post_id => @post.id)
			@comments = [stub_model(Comment, :author => "auteur", :body => "commentaire", :post_id => @post.id)]
			@posts = [@post]
			Post.stub(:find) { @post }
			Post.stub(:comments) { true }
			Comment.stub(:new) { @comment }

		end
		it "New doit retourner un post" do
			Post.should_receive(:find).and_return(@post)
			@post.should_receive(:comments).and_return(@comments)
			@comments.should_receive(:new).and_return(@comment)
			get :new, :post_id => @post.id
			assigns(:comment).should eq @comment
		end
	end

	describe "create" do
		before(:each) do
			@user = User.create(:email => "test@test.com", :password => "password", :password_confirmation => "password")
			@posts = [stub_model(Post,:title => "sujet1", :body => "rfhergzb", :user_id => @user.id, :note => 3.00), 
				  stub_model(Post,:title => "sujet3", :body => "rfhevfevfrgzb", :user_id => @user.id, :note => 3.00), 
				  stub_model(Post,:title => "sujet4", :body => "rregagfhergzb", :user_id => @user.id, :note => 3.00)]
			@post = @posts[0]
			@new_comment1 = {"author" => "new auteur", "body" => "new commentaire", "post_id" => @post.id}
			@new_comment2 = {"comment" => {"author" => "new auteur", "body" => "new commentaire"}}
			@comments = [stub_model(Comment, :author => "auteur", :body => "commentaire", :post_id => @post.id)]
			@post.comments = @comments
			Post.stub(:find) { @post }
			Post.stub(:comments) { true }
			Comment.stub(:create) { @commentcreated }
			controller.stub!(:require_user).and_return(@user)
			visit post_path(@post)
		end
		it "create doit retourner un comment" do
			Post.should_receive(:find).with(@new_comment1["post_id"].to_s).and_return(@post)
			@post.should_receive(:comments).and_return(@comments)
			@comments.should_receive(:create).with(@new_comment2["comment"]).and_return(@commentcreated)
			post :create, @new_comment1
			response.should redirect_to(post_path(@post))
		end
	end

	describe "destroy" do
		before(:each) do
			@user = User.create(:email => "test@test.com", :password => "password", :password_confirmation => "password")
			@posts = [stub_model(Post,:title => "sujet1", :body => "rfhergzb", :user_id => @user.id, :note => 3.00), 
				  stub_model(Post,:title => "sujet3", :body => "rfhevfevfrgzb", :user_id => @user.id, :note => 3.00), 
				  stub_model(Post,:title => "sujet4", :body => "rregagfhergzb", :user_id => @user.id, :note => 3.00)]
			@post = @posts[0]
			@comment = stub_model(Comment, :author => "auteur", :body => "commentaire", :post_id => @post.id)
			@comments = [@comment]
			Post.stub(:find) { @post }
			Post.stub(:comments) { true }
			Comment.stub(:find) { @comment }
			Comment.stub(:destroy) { true }
			controller.stub!(:require_user).and_return(@user)
			visit post_path(@post)
		end
		it "delete doit avoir supprimer un comment" do
			Post.should_receive(:find).with(@post.id.to_s).and_return(@post)
			@post.should_receive(:comments).and_return(@comments)
			@comments.should_receive(:find).with(@comment.id.to_s).and_return(@comment)
			@comment.should_receive(:destroy)
			delete :destroy, :post_id => @post.id, :id => @comment.id
			response.should redirect_to(post_path(@post))
		end
	end
end
