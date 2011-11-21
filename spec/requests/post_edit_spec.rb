require 'spec_helper'

describe "PostEdit" do
    before(:each) do
	@post = Post.create(:title => "sujet", :body => "bla bla")
	@posts = [@post]
  end
  describe "GET /posts/:id/edit" do
    it "Creation" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get edit_post_path(@post.id)
      response.status.should be(200)    
    end
    it "back link should exist" do
	visit edit_post_path(@post.id)
	page.should have_link('Back', :href => posts_path)
    end
    it "back link should take to the right pages" do
	    visit edit_post_path(@post.id)
 	    page.click_link("Back")
	    current_path.should eq posts_path
    end
    it "show link should exist" do
	visit edit_post_path(@post.id)
	page.should have_link('Show', :href => post_path(@post))
    end
    it "show link should take to the right pages" do
	    visit edit_post_path(@post.id)
 	    page.click_link("Show")
	    current_path.should eq post_path(@post)
    end
  end
end

