require 'spec_helper'

describe "UpdatePosts" do
  describe "GET /posts/new" do
    before(:each) do
      @posts = [Post.create(:title => "sujet1", :body => "bla "),
              	Post.create(:title => "sujet2", :body => "bla bla"),
      		Post.create(:title => "sujet3", :body => "bla bla bla")]
      @post = @posts[1]
      visit edit_post_path(@post.id)
    end
    it "displays a form to update a post" do
      page.should have_selector("form[action='/posts/#{@post.id}']")
    end

    it "should have a title field" do
      page.should have_field("Title")
    end

    it "should have a body field" do
      page.should have_field("Body")
    end

    it "should have a update post button" do
      page.should have_button("Update Post")
    end
  end

  describe "use edit post form" do
    before(:each) do
      @posts = [Post.create(:title => "sujet1", :body => "bla "),
              	Post.create(:title => "sujet2", :body => "bla bla"),
      		Post.create(:title => "sujet3", :body => "bla bla bla")]
      @post = @posts[1]
      visit edit_post_path(@post.id)
      fill_in("Title", :with => "post 1")
      fill_in("Body", :with => "updated body")
      click_button("Update Post")
    end
    it "should display the todo list" do
      current_path.should == posts_path
    end
    
  end

  describe "after a post has been updated" do
    before(:each) do
      @posts = [Post.create(:title => "sujet1", :body => "bla "),
              	Post.create(:title => "sujet2", :body => "bla bla"),
      		Post.create(:title => "sujet3", :body => "bla bla bla")]
      @post = @posts[1]
      visit posts_path
      within("tr", :text => @post.title) do
        	click_link("Edit Post")
      end
      current_path.should == edit_post_path(@post.id)
      fill_in("Title", :with => "post 1")
      fill_in("Body", :with => "updated body")
      click_button("Update Post")
      current_path.should == posts_path
    end

    it "should display the updated post in the list" do
      page.should have_content("post 1")
      page.should have_content("updated body")
    end
  end
      
end

