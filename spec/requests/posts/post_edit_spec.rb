require 'spec_helper'

describe "PostEdit" do
  describe "GET /posts/:id/edit" do

    before(:each) do
	@post = Post.create(:title => "sujet", :body => "bla bla")
	@posts = [@post]
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

    it "Creation" do
      visit edit_post_path(@post.id)
      fill_in("Title", :with => "post 1")
      fill_in("Body", :with => "created body")
      click_button("Update Post")
      visit posts_path
      page.should have_content("post 1")
      page.should have_content("created body")
    end
    it "back link should exist" do
	visit edit_post_path(@post.id)
	page.should have_link('Back', :href => posts_path)
    end
    it "back link should take to the right pages" do
	    visit edit_post_path(@post.id)
 	    page.click_link("Back")
	    current_path.should eq posts_path
    end
    it "show link should exist" do
	visit edit_post_path(@post.id)
	page.should have_link('Show', :href => post_path(@post))
    end
    it "show link should take to the right pages" do
	    visit edit_post_path(@post.id)
 	    page.click_link("Show")
	    current_path.should eq post_path(@post)
    end
  end
end

