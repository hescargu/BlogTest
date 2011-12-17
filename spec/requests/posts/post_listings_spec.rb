require 'spec_helper'

describe "PostListings" do
  before(:each) do
	@post1 = Post.create(:title => "sujet1", :body => "bla bla", :user_id => "1")
	@post2 = Post.create(:title => "sujet2", :body => "bla bla", :user_id => "1")
      @user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
      @params_user = {"user" => { :email =>  @user.email, :password => @user.password }}
      visit new_user_path
      #post "/users", @params_user
      fill_in("Email", :with => @user.email)
      fill_in("Password", :with => @user.password)
      fill_in("Password confirmation", :with => @user.password_confirmation)
      click_button("Create User")
      #post "/sessions", {:email => @user.email, :password => @user.password}
      visit new_session_path
      fill_in("Email", :with => @user.email)
      fill_in("Password", :with => @user.password)
      click_button("Log in")
  end
  describe "GET /post_listings" do
    it "Affichage" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit posts_path
	page.should have_content(@post1.title)
	page.should have_content(@post2.title)
    end
    it "show, edit and delete comment button should exist" do
	visit posts_path
	page.should have_button('Show Post')
	page.should have_button('Edit Post')
	page.should have_button('Delete Post')
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
