require 'spec_helper'

describe "CreateComments" do
    before(:each) do
	@user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
      	@post = Post.create(:title => "sujet", :body => "cacahuete", :user_id => @user.id, :note => 3.00)
      	@posts = [@post]
      	@comment = Comment.create(:author => "Helene", :body => "hello", :post_id => @post.id)
      	@comments = [@comment]
        visit new_session_path
        fill_in("Email", :with => @user.email)
        fill_in("Password", :with => @user.password)
        click_button("Log in")
    end
  describe "GET /posts/:id_post" do
    it "displays a link to create a new comment" do
      visit post_path(@post)
      page.should have_link("Add a comment")
    end
    it "displays a form to create new comment when clicking on the link" do
      visit post_path(@post)
      click_link("Add a comment")
      page.should have_selector("form", :method => "post", :action => "/posts/#{@post.id}/comments") do |form|
		form.should have_selector("div", :class => "field")
		form.should have_selector("label", :name => "author")
		form.should have_selector("text_field", :name => "author")
		form.should have_selector("label", :name => "body")
		form.should have_selector("text_area", :name => "body")
		form.should have_selector("submit")
      end
    end
  end

  describe "use new comment form" do
    it "should display the todo list" do
      visit post_path(@post)
      click_link("Add a comment")
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
         click_button("Show Post")
      end
      current_path.should == post_path(@post.id)
      click_link("Add a comment")
      fill_in("Author", :with => "auteur")
      fill_in("Body", :with => "commentaire")
      click_button("Create Comment")
      current_path.should == post_path(@post.id)
      page.should have_content("Helene")
      page.should have_content("hello")
    end
  end
     
end

