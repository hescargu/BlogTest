require 'spec_helper'

describe "CreateUsers" do

before(:each) do
      @user = {:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest"}
end
  describe "GET /users/new" do
    before(:each) do
      visit new_user_path	
    end
    it "displays a form to create a new user" do
      page.should have_selector("form#new_user")
    end

    it "should have a title field" do
      page.should have_field("Email")
    end

    it "should have a password field" do
      page.should have_field("Password")
    end

    it "should have a password_confirmation field" do
      page.should have_field("Password confirmation")
    end

    it "should have a create post button" do
      page.should have_button("Create User")
    end


  end

  describe "use new user form on new user page" do
    before(:each) do
      visit new_user_path
      fill_in("Email", :with => @user[:email])
      fill_in("Password", :with => @user[:password])
      fill_in("Password confirmation", :with => @user[:password_confirmation])
      click_button("Create User")
    end
    it "should display the post list connected as user created" do
      current_path.should == posts_path
      page.should have_content("Connected as #{@user[:email]}")
    end
    
  end


end

