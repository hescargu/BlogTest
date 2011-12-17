require 'spec_helper'

describe "DeleteComments" do
  describe "GET /posts/:id_post" do
    before(:each) do
	@user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
	@post = Post.create(:title => "sujet", :body => "cacahuete", :user_id => @user.id)
	@post.comments = [Comment.create(:author => "auteur", :body => "commentaire")]
        visit new_session_path
        fill_in("Email", :with => @user.email)
        fill_in("Password", :with => @user.password)
        click_button("Log in")
    end
    describe "a comment in the list" do
      it "should have a delete button" do
        visit post_path(@post)
        page.should have_button("Delete Comment")
      end
    end
    describe "after a click on the delete button on the 2nd post" do
      it "should display the list without the post2" do
	 visit post_path(@post)
       	 click_button("Delete Comment")
         current_path.should == post_path(@post)
         page.should_not have_content(@post.comments[0].body)
      end
    end
  end
end
