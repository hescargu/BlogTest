require 'spec_helper'

describe "DeletePosts" do

  before(:each) do
    @posts = [Post.create(:title => "sujet1", :body => "bla ", :user_id => "1"),
              Post.create(:title => "sujet2", :body => "bla bla", :user_id => "1"),
              Post.create(:title => "sujet3", :body => "bla bla bla", :user_id => "1")]
    @post = @posts[1]
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
    visit posts_path
  end

  describe "a post in the list" do
    it "should have a delete button" do
      visit posts_path
      @posts.each{|post| page.should have_link("Delete Post", :href => post_path(post), :method => 'delete')}
    end
  end

  describe "after a click on the delete link on the 2nd post" do
    it "should display the list without the post2" do
      	within("tr", :text => @post.title) do
       		click_link("Delete Post")
		current_path.should == posts_path
        end
        page.should_not have_content(@post.title)
    end
  end
end
