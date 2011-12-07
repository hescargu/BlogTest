require 'spec_helper'

describe "PostNew" do
    before(:each) do
	@post = Post.create(:title => "sujet", :body => "bla bla")
	@posts = [@post]
  end
  describe "GET /posts/new" do
    before(:each) do
      @user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
      @params_user = {"user" => { :email =>  @user.email, :password => @user.password }}
      visit new_user_path
      #log in
      fill_in("Email", :with => @user.email)
      fill_in("Password", :with => @user.password)
      fill_in("Password confirmation", :with => @user.password_confirmation)
      click_button("Create User")
      visit new_session_path
      fill_in("Email", :with => @user.email)
      fill_in("Password", :with => @user.password)
      click_button("Log in")
    end
    it "Creation" do
      visit new_post_path
      fill_in("Title", :with => "post 1")
      fill_in("Body", :with => "created body")
      click_button("Create Post")
      visit posts_path
      page.should have_content("post 1")
      page.should have_content("created body")  
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
