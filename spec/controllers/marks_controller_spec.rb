require 'spec_helper'

describe MarksController do
	describe "new" do
		before(:each) do
			@user = User.create(:email => "test@test.com", :password => "password", :password_confirmation => "password")
			@post = stub_model(Post,:title => "sujet", :body => "rfhgpqrvb", :user_id => @user.id, :note => 3.00)
			@mark = stub_model(Mark, :value => "3", :post_id => @post.id)
			@marks = [stub_model(Mark, :value => "1", :post_id => @post.id)]
			@posts = [@post]
			Post.stub(:find) { @post }
			Post.stub(:marks) { true }
			Comment.stub(:new) { @mark }

		end
		it "New doit retourner une mark" do
			Post.should_receive(:find).and_return(@post)
			@post.should_receive(:marks).and_return(@marks)
			@marks.should_receive(:new).and_return(@mark)
			get :new, :post_id => @post.id
			assigns(:mark).should eq @mark
		end
	end

	describe "create" do
		before(:each) do
			@user = User.create(:email => "test@test.com", :password => "password", :password_confirmation => "password")
			@posts = [stub_model(Post,:title => "sujet1", :body => "rfhergzb", :user_id => @user.id, :note => 3.00), 
				  stub_model(Post,:title => "sujet3", :body => "rfhevfevfrgzb", :user_id => @user.id, :note => 3.00), 
				  stub_model(Post,:title => "sujet4", :body => "rregagfhergzb", :user_id => @user.id, :note => 3.00)]
			@post = @posts[0]
			@new_mark1 = {"value" => "5", "post_id" => @post.id.to_s}
			@new_mark2 = {"mark" => {"value" => "5", "post_id" => @post.id.to_s}}
			@marks = [stub_model(Mark, :value => "2", :post_id => @post.id)]
			@post.marks = @marks
			Post.stub(:find) { @post }
			Post.stub(:marks) { true }
			Post.stub(:update_attribute) { true }
			Mark.stub(:create) { @markcreated }
			visit post_path(@post)
		end
		it "create doit retourner une mark" do
			Post.should_receive(:find).with(@new_mark1["post_id"]).and_return(@post)
			@post.should_receive(:marks).and_return(@marks)
			@post.should_receive(:marks).and_return(@marks)
			@marks.should_receive(:create).with(@new_mark2["mark"]).and_return(@markcreated)
			post :create, @new_mark1
			response.should redirect_to(post_path(@post))
		end
	end
end


