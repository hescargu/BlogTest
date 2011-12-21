require 'spec_helper'

describe "CreateMarks" do
    before(:each) do
	@user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
      	@post = Post.create(:title => "sujet", :body => "cacahuete", :user_id => @user.id)
      	@posts = [@post]
      	@mark = Mark.create(:value => 4, :post_id => @post.id)
      	@marks = [@mark]
        visit new_post_mark_path(@post)
        select("2", :from => "Value")
        click_button("Submit Mark")
    end

  describe "GET /posts/:id_post" do
    it "displays a link to create a new mark" do
      visit post_path(@post)
      page.should have_link("Mark this post")
    end
    it "displays a form to create new mark" do
      visit post_path(@post)
      click_link("Mark this post")
      page.should have_selector("form", :method => "post", :action => "/posts/#{@post.id}/marks") do |form|
		form.should have_selector("div", :class => "field")
		form.should have_selector("label", :name => "value")
		form.should have_selector("select", :name => "value")
		form.should have_selector("submit")
      end
    end
  end


  describe "after a new mark has been created" do
    it "should display the new mark in the list" do
      visit post_path(@post)
      click_link("Mark this post")
      current_path.should == new_post_mark_path(@post.id)
      select("3", :from => "Value")
      click_button("Submit Mark")
      current_path.should == post_path(@post.id)
      page.should have_content("Actual mark of this post :")
      page.should have_content("3.00/5")
    end
  end
     
end

