require 'spec_helper'

describe "posts/show.html.erb" do
	before (:each) do
		@user = User.create(:email => "test@test.com", :password => "pwdtest", :password_confirmation => "pwdtest")
		view.stub!(:current_user).and_return(@user)
		@post = stub_model(Post, :title => "sujet", :body => "cacahuete", :user_id => @user.id)
		@comments = [stub_model(Comment, :author => "auteur", :body => 'commentaire bla bla bla', :post_id => @post.id)]
		@post.comments = @comments
		assign(:post, @post)
	end
	describe "Affichage du post et des links" do
		it "should display the post" do
			#on calcule le template
			render
			rendered.should have_content("#{@post.title}")
			rendered.should have_content("#{@post.body}")
			rendered.should have_content("#{User.find(@post.user_id).email}")
			rendered.should have_content("#{@post.created_at.to_s.chomp('UTC')}")
			rendered.should have_content("#{@post.updated_at.to_s.chomp('UTC')}")
		end
		it "link should exist" do
			render 
			rendered.should have_link('Back', :href => posts_path)
		end
		it "link should exist" do
			render 
			rendered.should have_link('Edit', :href => edit_post_path(@post.id))
		end
	end
	describe 'user is not the author of the post' do
		before(:each) do 
			@user2 = User.create(:email => "test2@test.com", :password => "pwdtest2", :password_confirmation => "pwdtest2")
			@post = stub_model(Post, :title => "sujet", :body => "cacahuete", :user_id => @user2.id)
		end
		it 'can not edit the post' do
			render 
			rendered.should_not have_link('Edit', :href => edit_post_path(@post.id))
		end
	end 
	describe 'commentaires' do
		it 'list comments' do
			render
			rendered.should have_selector("table td")
			rendered.should have_content(@comments[0].author)
			rendered.should have_content(@comments[0].body)
			rendered.should have_content(@comments[0].created_at.to_s.chomp('UTC'))

		end

		it "affiche le lien d'affichage du formulaire de nouveau commentaire" do
		  render
		  render.should have_link('Add a comment')
		end

		it "affiche le lien de suppression d'un commentaire" do
			render
			rendered.should have_button('Delete Comment')
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
