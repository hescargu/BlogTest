require 'spec_helper'

describe "CreateComments" do
  describe "GET /posts/:id" do
    before(:each) do
      @post = Post.create(:title => "sujet", :body => "cacahuete")
      @posts = [@post]
    end
    it "displays a form to create a new comment" do
      visit post_path(@post)
      page.should have_selector("commentform#new_comment")
      page.should have_field("Author")
      page.should have_field("Comment")
      page.should have_button("Create Comment")
    end
  end

  describe "use new comment form" do
    it "should display the todo list" do
      @post = Post.create(:title => "sujet", :body => "cacahuete")
      @posts = [@post]
      visit post_path(@post.id)
      fill_in("Author", :with => "auteur")
      fill_in("Comment", :with => "commentaire")
      click_button("Create Comment")
      current_path.should == post_path(@post.id)
    end
    
  end

  describe "after a new comment has been created" do
    before(:each) do
      @post = Post.create(:title => "sujet", :body => "cacahuete")
      @posts = [@post]
    end

    it "should display the new comment in the list" do
      visit posts_path
      within("tr", :text => @post.title) do
	      click_link("Show Post")
      end
      current_path.should == post_path(@post.id)
      fill_in("Author", :with => "auteur")
      fill_in("Comment", :with => "commentaire")
      click_button("Create Comment")
      current_path.should == post_path(@post.id)
      page.should have_content("auteur")
      page.should have_content("commentaire")
    end
  end
     
end

