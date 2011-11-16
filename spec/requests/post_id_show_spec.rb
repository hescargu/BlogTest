require 'spec_helper'

describe "PostIdShow" do
  before(:each) do
	@post = Post.create(:title => "sujet", :body => "bla bla")
  end
  describe "GET /posts/:id" do
	it "affichagePost" do
		get "/posts/#{@post.id}" 
		response.status.should be(200)
		response.body.should include(@post.title)
		response.body.should include(@post.body)	
	end
	it "link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Back', :href => posts_path)
	end
        it "back link should take to the right pages" do
	    visit "/posts/#{@post.id}"
 	    page.click_link("Back")
	    current_path.should eq posts_path
        end
	it "link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Edit', :href => edit_post_path(@post.id))
	end
        it "edit link should take to the right pages" do
	    visit "/posts/#{@post.id}"
 	    page.click_link("Edit")
	    current_path.should eq edit_post_path(@post.id)
        end	
  end
end


