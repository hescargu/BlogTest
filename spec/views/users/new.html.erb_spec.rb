require 'spec_helper'

describe "/users/new" do
	describe "users/new.html.erb" do
		before (:each) do
			@user = stub_model(User, :email => "test@test.com", :password => "password", :password_confirmation => "password") 
			assign(:users, [@user])
		end
		it "devrait afficher le formulaire" do
			render
			rendered.should have_selector("form", :method => "post", :action => "/users") do |form|
				form.should have_selector("div", :class => "field")
				form.should have_selector("label", :name => "email")
				form.should have_selector("text_field", :name => "email")
				form.should have_selector("label", :name => "password")
				form.should have_selector("password_field", :name => "password")
				form.should have_selector("label", :name => "password_confirmation")
				form.should have_selector("password_field", :name => "password_confirmation")
				form.should have_selector("submit")
			end
		end
	end
end
