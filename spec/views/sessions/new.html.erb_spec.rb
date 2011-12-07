require 'spec_helper'

describe "/sessions/new" do

	describe "sessions/new.html.erb" do
		before (:each) do
			@user = stub_model(User, :email => "test@test.com", :password => "password", :password_confirmation => "password") 
			assign(:users, [@user])
		end
		it "devrait afficher le formulaire" do
			render
			rendered.should have_selector("form", :method => "post", :action => "/sessions") do |form|
				form.should have_selector("div", :class => "field")
				form.should have_selector("label", :name => "email")
				form.should have_selector("text_field", :name => "email")
				form.should have_selector("label", :name => "password")
				form.should have_selector("password_field", :name => "password")
				form.should have_selector("submit")
			end
		end

		it "link to create an account should exist" do
		render
		rendered.should have_link('Create an account', :href => new_user_path)
		end
	end
end
