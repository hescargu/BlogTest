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
    it "show, edit and delete comment link should exist" do
	visit posts_path
	page.should have_link('Show Post')
	page.should have_link('Edit Post')
	page.should have_link('Delete Post')
    end
    it "new post link should exist" do
	visit posts_path
	page.should have_link('New Post', :href => new_post_path)
    end
    it "form should appear by clicking on the new post link " do
	visit posts_path
        page.click_link("New Post")
	page.should have_selector("form", :method => "post", :action => "/posts") do |form|
		form.should have_selector("div", :class => "field")
		form.should have_selector("label", :name => "title")
		form.should have_selector("text_field", :name => "title")
		form.should have_selector("label", :name => "body")
		form.should have_selector("text_area", :name => "body")
		form.should have_selector("submit")
	end
end
  end
end
