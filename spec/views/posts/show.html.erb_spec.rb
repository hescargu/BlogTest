require 'spec_helper'

describe "posts/show.html.erb" do
	before (:each) do
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete")
		@comments = [stub_model(Comment, :author => "auteur", :body => 'commentaire bla bla bla', :post_id => @post.id)]
		@post.comments = @comments
		@user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
		view.stub!(:current_user).and_return(@user)
		assign(:post, @post)
	end
	describe "Affichage du post et des links" do
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
		it "Log out link should exist" do
			render	
			rendered.should have_link('Log out')
		end
	end
	describe 'commentaires' do
		it 'list comments' do
			render
			rendered.should have_selector("table td")
			rendered.should have_content(@comments[0].author)
			rendered.should have_content(@comments[0].body)

		end

		it "affiche le lien d'affichage du formulaire de nouveau commentaire" do
		  render
		  render.should have_link('Add a comment')
		end

		it "affiche le lien de suppression d'un commentaire" do
			render
			rendered.should have_link('Delete Comment')
		end
	end
	describe "lien log in quand user non authentifie" do
		before (:each) do
			view.stub!(:current_user).and_return(nil)
		end

		it "Log in link should exist" do
			render	
			rendered.should have_link('Log in', :href => new_session_path)
		end		
	end

end
