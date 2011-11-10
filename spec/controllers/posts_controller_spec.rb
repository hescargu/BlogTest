require 'spec_helper'

describe PostsController do
	describe "index" do
		before(:each) do
			@posts = [stub_model(Post,:title => "sujet 10"), stub_model(Post, :title => "sujet 20")]
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
end
