require 'spec_helper'

describe "DeletePosts" do

  before(:each) do
    @user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
    @posts = [Post.create(:title => "sujet1", :body => "bla ", :user_id => @user.id),
              Post.create(:title => "sujet2", :body => "bla bla", :user_id => @user.id),
              Post.create(:title => "sujet3", :body => "bla bla bla", :user_id => @user.id)]
    @post = @posts[1]
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
    visit posts_path
  end

  describe "a post in the list" do
    it "should have a delete button" do
      visit posts_path
      @posts.each{|post| page.should have_button("Delete Post")}
    end
  end

  describe "after a click on the delete button on the 2nd post" do
    it "should display the list without the post2" do
      	within("tr", :text => @post.title) do
       		click_button("Delete Post")
		current_path.should == posts_path
        end
        page.should_not have_content(@post.title)
    end
  end
end
