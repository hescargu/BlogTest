require 'spec_helper'

describe "posts/index.html.erb" do

	before (:each) do
		#prérequis : @posts contient des objets ressemblant à un post
		@user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
		@user2 = User.create(:email => "test2@test.com", :password => "pwdtest2", :password_confirmation => "pwdtest2")
		@post1 = stub_model(Post, :title => "sujet 1", :body => "corps1", :user_id => @user.id) 
		@post2 = stub_model(Post, :title => "sujet 2", :body => "corps2", :user_id => @user.id)
		@post3 = stub_model(Post, :title => "sujet 3", :body => "corps3", :user_id => @user2.id)
		@posts = [@post1, @post2, @post3]
		assign(:posts, [@post1,@post2,@post3])
		view.stub(:current_user).and_return(@user)
	end

	describe "posts/index.html.erb avec authentification" do
		it "should display a html list" do
			#on calcule le template
			render
			rendered.should have_selector("table td")
			rendered.should have_content("#{@post1.title}")
			rendered.should have_content("#{@post1.body}")
			rendered.should have_content("#{@post2.title}")
			rendered.should have_content("#{@post2.body}")
			rendered.should have_content("(yours)")
		end
		it "delete post button should exist" do
			render	
			rendered.should have_button('Delete Post')
		end
		it "edit post button should exist" do
			render	
			rendered.should have_button('Edit Post')
		end
		it "show post button should exist" do
			render	
			rendered.should have_button('Show Post')
		end
		it "New post link should exist" do
			render	
			rendered.should have_link('New Post', :href => new_post_path)
		end
		it "Log out link should exist" do
			render	
			rendered.should have_link('Log out')
		end
		it "delete account link should exist" do
			render	
			rendered.should have_link('Delete your account')
		end
	end

	describe "posts/index.html.erb avec mauvaise authentification" do
		before(:each) do
			@posts = [@post3]
			assign(:posts, [@post3])
		end
		it "delete post button should not exist" do
			render	
			rendered.should_not have_button('Delete Post')
		end
		it "edit post button should not exist" do
			render	
			rendered.should_not have_button('Edit Post')
		end
	end

	describe "posts/index.html.erb sans authentification" do
		before (:each) do
			view.stub!(:current_user).and_return(nil)
		end
		it "should display a html list" do
			#on calcule le template
			render
			rendered.should have_selector("table td")
			rendered.should have_content("#{@post1.title}")
			rendered.should have_content("#{@post1.body}")
			rendered.should have_content("#{@post2.title}")
			rendered.should have_content("#{@post2.body}")
		end
		it "show post button should exist" do
			render	
			rendered.should have_button('Show Post')
		end
		it "delete post button should not exist" do
			render	
			rendered.should_not have_button('Delete Post')
		end
		it "edit post button should not exist" do
			render	
			rendered.should_not have_button('Edit Post')
		end
		it "Log in link should exist" do
			render	
			rendered.should have_link('Log in', :href => new_session_path)
		end	
		it "Create account link should exist" do
			render	
			rendered.should have_link('Create an account', :href => new_user_path)
		end		
	end

end
