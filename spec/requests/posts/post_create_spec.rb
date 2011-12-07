require 'spec_helper'

describe "CreatePosts" do
before(:each) do
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

  describe "use new post form on new post page" do
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

  describe "use new post form on the main page" do
    before(:each) do
      visit posts_path
      click_link("New Post")
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

