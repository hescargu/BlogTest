require 'spec_helper'



describe "posts/show.html.erb" do
pending "probleme rendered.should have_link('Delete Comment'..."
	before (:each) do
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete")
		@comments = [stub_model(Comment, :author => "auteur", :body => 'commentaire bla bla bla', :post_id => @post.id)]
		@post.comments = @comments
		assign(:post, @post)


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
	describe 'commentaires' do
		it 'list comments' do
			render
			rendered.should have_selector("form", :method => "get", :action => "/posts/#{@post.id}/comments") do |form|
				form.should have_selector("table td")
				form.should have_content(@comments[0].author)
				form.should have_content(@comments[0].body)
				form.should have_content("Delete Comment")
			end
		end

		it "affiche le formulaire de nouveau commentaire" do
		  render
		  rendered.should have_selector("form", :method => "post", :action => "/posts/#{@post.id}/comments") do |form|
			form.should have_selector("div", :class => "field")
			form.should have_selector("label", :name => "author")
			form.should have_selector("text_field", :name => "author")
			form.should have_selector("label", :name => "body")
			form.should have_selector("text_area", :name => "body")
			form.should have_selector("submit")
		  end
		end

		it "affiche le bouton de suppression d'un commentaire" do
			render
			#rendered.should have_link('Delete Comment', "/posts/#{@post.id}/comments/#{@comments[0].id}")
		end
	end
end
