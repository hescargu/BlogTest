require 'spec_helper'

describe "posts/index.html.erb" do
	it "should display a html list" do
		#prérequis : @posts contient des objets ressemblant à un post
		@post1 = stub_model(Post, :title => "sujet 1") 
		@post2 = stub_model(Post, :title => "sujet 2")
		assign(:posts, [@post1,@post2])
		#on calcule le template
		render
		#je veux <ul><li> Titre post</li><li> Titre post2 </li></ul>
		rendered.should have_selector("ul li")
		rendered.should have_content("#{@post1.title}")
		rendered.should have_content("#{@post2.title}")
	end

end
