require 'spec_helper'

describe "posts/new.html.erb" do
	before (:each) do
		#prérequis : @posts contient des objets ressemblant à un post
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete") 
		assign(:posts, [@post])
	end
	it "devrait afficher le formulaire" do
		#on calcule le template
		render
		rendered.should have_selector("form", :method => "post", :action => "/posts") do |form|
			form.should have_selector("div", :class => "field")
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
