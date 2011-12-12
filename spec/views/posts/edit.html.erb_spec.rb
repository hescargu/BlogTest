require 'spec_helper'

describe "posts/edit.html.erb" do
	before (:each) do
		#prérequis : @posts contient des objets ressemblant à un post
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete", :user_id => "1") 
		assign(:posts, [@post])
	end
	it "should display the post" do
		#on calcule le template
		render
		rendered.should have_selector("form", :method => "put", :action => "/posts/#{@post.id}") do |form|
			form.should have_selector("div", :class => "field")
			form.should have_selector("label", :name => "title")
			form.should have_selector("text_field", :name => "title")
			form.should have_selector("label", :name => "body")
			form.should have_selector("text_area", :name => "body")
			form.should have_selector("submit")
		end
	end
	    it "Show link should exist" do
		render
		rendered.should have_link('Show', :href => post_path(@post.id))
	    end
	    it "Back link should exist" do
		render
		rendered.should have_link('Back', :href => posts_path)
	    end

end
