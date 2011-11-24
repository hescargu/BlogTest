require 'spec_helper'

describe "CreateComments" do
  describe "GET /posts/:id" do
    before(:each) do
      @post = stub_model(Post, :title => "sujet", :body => "cacahuete")
      @posts = [@post]
      visit post_path(@post.id)
    end
    it "displays a form to create a new comment" do
      page.should have_selector("commentform#new_comment")
    end

    it "should have a author field" do
      page.should have_field("Author")
    end

    it "should have a comment field" do
      page.should have_field("Comment")
    end

    it "should have a create comment button" do
      page.should have_button("Create Comment")
    end
  end

  describe "use new comment form" do
    before(:each) do
      @post = stub_model(Post, :title => "sujet", :body => "cacahuete")
      @posts = [@post]
      visit post_path(@post.id)
      fill_in("Author", :with => "auteur")
      fill_in("Comment", :with => "commentaire")
      click_button("Create Comment")
    end
    it "should display the todo list" do
      current_path.should == post_path(@post.id)
    end
    
  end

  describe "after a new comment has been created" do
    before(:each) do
      @post = stub_model(Post, :title => "sujet", :body => "cacahuete")
      @posts = [@post]
      visit posts_path
      within("tr", :text => @post.title) do
	      click_link("Show Post")
      end
      current_path.should == post_path(@post.id)
      fill_in("Author", :with => "auteur")
      fill_in("Comment", :with => "commentaire")
      click_button("Create Comment")
      current_path.should == post_path(@post.id)
    end

    it "should display the new comment in the list" do
      page.should have_content("auteur")
      page.should have_content("commentaire")
    end
  end
     
end

