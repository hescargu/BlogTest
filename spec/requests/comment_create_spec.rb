require 'spec_helper'

describe "CreateComments" do
    before(:each) do
      @post = Post.create(:title => "sujet", :body => "cacahuete")
      @posts = [@post]
      @comment = Comment.create(:author => "Helene", :body => "hello", :post_id => @post.id)
      @comments = [@comment]
    end
  describe "GET /posts/:id_post" do
    it "displays a form to create a new comment" do
      visit post_path(@post)
      page.should have_selector("form")
      page.should have_field("Author")
      page.should have_field("Body")
      page.should have_button("Create Comment")
    end
  end

  describe "use new comment form" do
    it "should display the todo list" do
      visit post_path(@post)
      fill_in("Author", :with => "auteur")
      fill_in("Body", :with => "commentaire")
      click_button("Create Comment")
      current_path.should == post_path(@post.id)
    end
    
  end

  describe "after a new comment has been created" do
    it "should display the new comment in the list" do
      visit posts_path
      within("tr", :text => @post.title) do
         click_link("Show Post")
      end
      current_path.should == post_path(@post.id)
      fill_in("Author", :with => "auteur")
      fill_in("Body", :with => "commentaire")
      click_button("Create Comment")
      current_path.should == post_path(@post.id)
      page.should have_content("Helene")
      page.should have_content("hello")
    end
  end
     
end

