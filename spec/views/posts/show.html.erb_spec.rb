require 'spec_helper'

describe "posts/show.html.erb" do
	before (:each) do
		#prérequis : @posts contient des objets ressemblant à un post
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete") 
		assign(:posts, [@post])
	end
	it "should display the post" do
		#on calcule le template
		render
		rendered.should have_content("#{@post.title}")
		rendered.should have_content("#{@post.body}")
	end
	it "link should exist" do
		render 
		rendered.should have_link('Back', :href => posts_path)
	end
	it "link should exist" do
		render 
		rendered.should have_link('Edit', :href => edit_post_path(@post.id))
	end
#	describe 'commentaires' do
#		it 'liste les commentaires' do

#			render
#			rendered.should have_content(@comments[0].author)
#			rendered.should have_content(@comments[0].body)			
#		end

#		it "affiche le formulaire de nouveau commentaire" do
#		  render
#		  rendered.should have_selector("commentform", :method => "put", :action => "/posts/#{@post.id}") do |form|
#			form.should have_selector("div", :class => "field")
#			form.should have_selector("label", :name => "title")
#			form.should have_selector("text_field", :name => "title")
#			form.should have_selector("label", :name => "body")
#			form.should have_selector("text_area", :name => "body")
#			form.should have_selector("submit")
#		  end

#		it "affiche le bouton de suppression d'un commentaire" do
#			render
#			rendered.should have_link('Delete Comment', :href => "/posts/#{@post.id}/comments/#{@comments[0].id}", :method => :delete)
#		end

#	end
end
