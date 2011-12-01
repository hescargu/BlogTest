require 'spec_helper'

describe PostsController do
	describe "index" do
		before(:each) do
			@posts = [stub_model(Post,:title => "sujet 1"), stub_model(Post, :title => "sujet 2")]
			#change le résultat de Post.all
			Post.stub(:all) { @posts } #renvoi @posts à la place du vrai résultat du Post.all
		end
		it "Index doit retourner tous les posts" do
			#doit appeler Post.all
			Post.should_receive(:all).and_return(@posts) #dans le controler il doit y avoir la méthode .all
			#appel de l'action du controller
			get :index	
			#doit affecter la variable @posts
			assigns(:posts).should eq @posts
		end
	end
	describe "show" do
		before(:each) do
			@post = stub_model(Post,:title => "sujet", :body => "rfhgpqrvb")
			@posts = [@post]
			#change le résultat de Post.find
			Post.stub(:find) { @post } #renvoi @post à la place du vrai résultat du Post.find
		end
		it "Show retourner le post" do
			Post.should_receive(:find).and_return(@post)
			#appel de l'action du controller
			get :show, :id => @post.id
			#doit affecter la variable @post
			assigns(:post).should eq @post
		end
	end
	describe "edit" do
		before(:each) do
			@post = stub_model(Post,:title => "sujet", :body => "rfhgpqrvb")
			@posts = [@post]
			#change le résultat de Post.find
			Post.stub(:find) { @post } #renvoi @post à la place du vrai résultat du Post.find
		end
		it "Edit doit retourner un post" do
			Post.should_receive(:find).and_return(@post)
			#appel de l'action du controller
			get :edit, :id => @post.id
			#doit affecter la variable @post
			assigns(:post).should eq @post
		end
	end
	describe "new" do
		before(:each) do
			@post = stub_model(Post,:title => "sujet", :body => "rfhgpqrvb")
			@post2 = stub_model(Post,:title => "sujet2", :body => "rfhergzb")
			@posts = [@post2]
			#change le résultat de Post.new
			Post.stub(:new) { @post }
		end
		it "New doit retourner un post" do
			Post.should_receive(:new).and_return(@post)
			#appel de l'action du controller
			get :new
			#doit affecter la variable @post
			assigns(:post).should eq @post
		end
	end
	describe "create" do
		before(:each) do
			@post2 = stub_model(Post,:title => "sujet2", :body => "rfhergzb")
			@post_params = {"post" => { "title" => "post_title", "body" => "post_body"}}
			@posts = [@post2]
			Post.stub(:create) { @post }
			Post.stub(:save) {true}
		end
		it "create doit retourner un post" do
			Post.should_receive(:create).with(@post_params["post"]).and_return(@post)	
			@post.should_receive(:save).and_return("true")		
			post :create, @post_params
			response.should redirect_to(posts_path)
		end
	end


	describe "update" do
		before(:each) do
			@post = stub_model(Post,:title => "sujet2", :body => "rfhergzb")
			@posts = [@post]
			title = "edit title"
			body = "edit body"
			@new_post = {"title" => title, "body" => body}	
			Post.stub(:update_attributes){ true }		
			Post.stub(:find){ @post }
		end
		it "should update the post with the given params" do 
			Post.should_receive(:find).and_return(@post)
			@post.should_receive(:update_attributes).with(@new_post).and_return("true")
			put :update, {:id => @post.id, :post => @new_post}
			response.should redirect_to(posts_path)
		end
  	end


	describe "destroy" do
	    before(:each) do
	      @post = stub_model(Post, :title => "sujet", :body => "rfhgpqrvb")
	      @post.stub(:destroy){ true }
	      Post.stub(:find){ @post }
	    end
	    it "should redirect to the posts list" do
	      delete :destroy, {:id => @post.id }
	      response.should redirect_to posts_path
	    end

	    it "should search the post" do
	      Post.should_receive(:find).with(@post.id.to_s).and_return(@post)
	      delete :destroy, {:id => @post.id }
	    end

	    it "should destroy the post" do
	      @post.should_receive(:destroy)
	      delete :destroy, {:id => @post.id }
	    end
	end
end
