require 'spec_helper'

describe PostsController do
	describe "index" do
		before(:each) do
			@posts = [stub_model(Post,:title => "sujet 1"), stub_model(Post, :title => "sujet 2")]
			#change le résultat de Post.all
			Post.stub(:all) { @posts } #renvoi @posts à la place du vrai résultat du Post.all
		end
		it "should retrive all the posts" do
			#doit appeler Post.all
			Post.should_receive(:all).and_return(@posts) #dans le controler il doit y avoir la méthode .all
			#appel de l'action du controller
			get :index	
			#doit affecter la variable @posts
			assigns(:posts).should eq @posts
		end
	end
#	describe "new" do
#		before(:each) do
#			@post = stub_model(Post)
#			#change le résultat 
#			Post.stub(:new) { @post } #renvoi @post à la place du vrai résultat du Post.all
#		end	
#	end
	describe "show" do
		before(:each) do
			@post = stub_model(Post,:title => "sujet", :body => "rfhgpqrvb")
			@posts = [@post]
			#change le résultat de Post.find
			Post.stub(:find) { @post } #renvoi @post à la place du vrai résultat du Post.find
		end
		it "should retrive all the posts" do
			#doit appeler Post.all
			Post.should_receive(:find).and_return(@post)
			#appel de l'action du controller
			get :show, :id => @post.id
			#doit affecter la variable @post
			assigns(:post).should eq @post
		end
	end

end
