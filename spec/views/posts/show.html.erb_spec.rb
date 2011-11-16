require 'spec_helper'

describe "posts/show.html.erb" do
	before (:each) do
		#prérequis : @posts contient des objets ressemblant à un post
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete") 
		assign(:posts, [@post])
	end
	it "should display the post" do
		#on calcule le template
		render
		rendered.should have_content("#{@post.title}")
		rendered.should have_content("#{@post.body}")
	end
	it "link should exist" do
		render 
		rendered.should have_link('Back', :href => posts_path)
	end
	it "link should exist" do
		render 
		rendered.should have_link('Edit', :href => edit_post_path(@post.id))
	end
end
