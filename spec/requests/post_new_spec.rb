require 'spec_helper'

describe "PostNew" do
    before(:each) do
	@post = Post.create(:title => "sujet", :body => "bla bla")
	@posts = [@post]
  end
  describe "GET /posts/new" do
    it "Creation" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get new_post_path
      response.status.should be(200)    
    end
    it "link should exist" do
	visit new_post_path
	page.should have_link('Back', :href => posts_path)
    end
    it "back link should take to the right pages" do
	    visit new_post_path
 	    page.click_link("Back")
	    current_path.should eq posts_path
    end
  end
end
