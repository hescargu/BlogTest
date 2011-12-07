require 'spec_helper'

describe "PostIdShow" do
  before(:each) do
	@post = Post.create(:title => "sujet", :body => "cacahuete")
	@comments = [Comment.create(:author => "auteur", :body => 'commentaire bla bla bla', :post_id => @post.id)]
	@post.comments = @comments
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
  describe "GET /posts/:id" do
	it "affichagePost" do
		get "/posts/#{@post.id}" 
		response.status.should be(200)
		response.body.should include(@post.title)
		response.body.should include(@post.body)	
	end
	it "link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Back', :href => posts_path)
	end
        it "back link should take to the right pages" do
	    visit "/posts/#{@post.id}"
 	    page.click_link("Back")
	    current_path.should eq posts_path
        end
	it "should have the list of the comments" do
		visit "/posts/#{@post.id}"
		page.body.should include(@post.comments[0].author)
		page.body.should include(@post.comments[0].body)
	end
	it "new comment link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Add a comment', :href => new_post_comment_path(@post.id))
	end
	it "new comment link should display the new comment form" do
		visit "/posts/#{@post.id}"
		click_link('Add a comment')
		page.should have_selector("form", :method => "post", :action => "/posts/#{@post.id}/comments") do |form|
			form.should have_selector("div", :class => "field")
			form.should have_selector("label", :name => "author")
			form.should have_selector("text_field", :name => "author")
			form.should have_selector("label", :name => "body")
			form.should have_selector("text_area", :name => "body")
			form.should have_selector("submit")
		end
	end
	it "edit comment link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Edit', :href => edit_post_path(@post.id))
	end
        it "edit link should take to the right pages" do
	    visit "/posts/#{@post.id}"
 	    page.click_link("Edit")
	    current_path.should eq edit_post_path(@post.id)
        end	
  end
end


