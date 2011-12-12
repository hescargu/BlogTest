require 'spec_helper'

describe "posts/new.html.erb" do
	before (:each) do
		@current_user = mock_model(User, :email => "test@test.com", :password => "password", :password_confirmation => "password")
		
		controller.stub!(:current_user).and_return(@current_user)
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete", :user_id => @current_user.id) 
		assign(:posts, [@post])
	end
	it "devrait afficher le formulaire" do
		#on calcule le template
		render
		rendered.should have_selector("form", :method => "post", :action => "/posts") do |form|			
			form.should have_selector("div", :class => "field")
			form.should have_selector("hidden_field", :name => "user_id")
			form.should have_selector("label", :name => "title")
			form.should have_selector("text_field", :name => "title")
			form.should have_selector("label", :name => "body")
			form.should have_selector("text_area", :name => "body")
			form.should have_selector("submit")
		end
	end

    it "link should exist" do
	render
	rendered.should have_link('Back', :href => posts_path)
    end

end
