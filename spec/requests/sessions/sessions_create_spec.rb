require 'spec_helper'

describe "CreateSessions" do
before(:each) do
      @user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
end
  describe "GET /sessions/new" do
    before(:each) do
      visit new_session_path	
    end
    it "displays a form to create a new session" do
      page.should have_selector("form")
    end

    it "should have a title field" do
      page.should have_field("Email")
    end

    it "should have a password field" do
      page.should have_field("Password")
    end


    it "should have a log in button" do
      page.should have_button("Log in")
    end


  end

  describe "use new session form on new user page" do
    before(:each) do
      visit new_session_path
      fill_in("Email", :with => @user.email)
      fill_in("Password", :with => @user.password)
      click_button("Log in")
    end
    it "should display the post list connected as the user logged in" do
      current_path.should == posts_path
      page.should have_content("Connected as #{@user[:email]}")
    end
    
  end


end

