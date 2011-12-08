require 'spec_helper'

describe "DeletePosts" do

  before(:each) do
      @user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
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
    visit posts_path
  end

  describe "the index post page" do
    it "should have a delete account link" do
      visit posts_path
      page.should have_link("Delete your account")
    end
  end

  describe "after a click on the delete account link" do
    it "should not display delete account link anymore" do
	click_link("Delete your account")
	current_path.should == posts_path
        page.should_not have_link("Delete your account")
    end
  end
end
