require 'spec_helper'

describe "PostListings" do
  before(:each) do
	@post1 = Post.create(:title => "sujet1", :body => "bla bla")
	@post2 = Post.create(:title => "sujet2", :body => "bla bla")
  end
  describe "GET /post_listings" do
    it "Affichage" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.status.should be(200)
	response.body.should include(@post1.title)
	response.body.should include(@post2.title)
    end
    it "link should exist" do
	visit posts_path
	page.should have_link('New Post', :href => new_post_path)
    end
    it "nav links should take to the right pages" do
	visit posts_path
        page.click_link("New Post")
        current_path.should eq new_post_path
    end
  end
end
