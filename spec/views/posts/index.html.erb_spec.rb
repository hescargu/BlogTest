require 'spec_helper'

describe "posts/index.html.erb" do
	before (:each) do
		#prérequis : @posts contient des objets ressemblant à un post
		@post1 = stub_model(Post, :title => "sujet 1") 
		@post2 = stub_model(Post, :title => "sujet 2")
		assign(:posts, [@post1,@post2])
	end
	it "should display a html list" do
		#on calcule le template
		render
		#je veux <ul><li> Titre post</li><li> Titre post2 </li></ul>
		rendered.should have_selector("table td")
		rendered.should have_content("#{@post1.title}")
		rendered.should have_content("#{@post2.title}")
	end
	it "delete post link should exist" do
		render	
		rendered.should have_link('Delete Post')
	end
	it "edit post link should exist" do
		render	
		rendered.should have_link('Edit Post')
	end
	it "show post link should exist" do
		render	
		rendered.should have_link('Show Post')
	end
	it "New post link should exist" do
		render	
		rendered.should have_link('New Post', :href => new_post_path)
	end

end
