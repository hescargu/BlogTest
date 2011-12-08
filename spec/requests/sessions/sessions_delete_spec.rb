require 'spec_helper'

describe "DeletePosts" do
pending "test de creation de session quand session supprimee"
  before(:each) do
      @user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
      visit new_session_path
      fill_in("Email", :with => @user.email)
      fill_in("Password", :with => @user.password)
      click_button("Log in")
    visit posts_path
  end

  describe "the index post page" do
    it "should have a log out link" do
      visit posts_path
      page.should have_link("Log out")
    end
  end

  describe "after a click on the log out link" do
    it "should not display log out link anymore" do
	click_link("Delete your account")
	current_path.should == posts_path
        page.should_not have_link("Log out")
        page.should have_link("Log in")
    end
  end
end
