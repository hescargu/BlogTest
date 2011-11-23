require 'spec_helper'

describe "CreatePosts" do
  describe "GET /posts/new" do
    before(:each) do
      visit new_post_path
    end
    it "displays a form to create a new post" do
      page.should have_selector("form#new_post")
    end

    it "should have a title field" do
      page.should have_field("Title")
    end

    it "should have a body field" do
      page.should have_field("Body")
    end

    it "should have a create post button" do
      page.should have_button("Create Post")
    end
  end

  describe "use new post form" do
    before(:each) do
      visit new_post_path
      fill_in("Title", :with => "post 1")
      fill_in("Body", :with => "created body")
      click_button("Create Post")
    end
    it "should display the todo list" do
      current_path.should == posts_path
    end
    
  end

  describe "after a new post has been created" do
    before(:each) do
      visit posts_path
      click_link("New Post")
      current_path.should == new_post_path
      fill_in("Title", :with => "post 1")
      fill_in("Body", :with => "created body")
      click_button("Create Post")
      current_path.should == posts_path
    end

    it "should display the new post in the list" do
      page.should have_content("post 1")
      page.should have_content("created body")
    end
  end
      
end

