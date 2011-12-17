require 'spec_helper'

describe "comments/new.html.erb" do
	before (:each) do
		@user = mock_model(User, :email => "test@test.com", :password => "password", :password_confirmation => "password")
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete", :user_id => @user.id) 
		assign(:posts, [@post])
	end
	it "devrait afficher le formulaire" do
		#on calcule le template
		render
		rendered.should have_selector("form", :method => "post", :action => "/posts/#{@post.id}/comments") do |form|			
			form.should have_selector("label", :name => "author")
			form.should have_selector("text_field", :name => "author")
			form.should have_selector("label", :name => "body")
			form.should have_selector("text_area", :name => "body")
			form.should have_selector("submit")
		end
	end
end

