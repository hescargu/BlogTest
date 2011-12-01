require 'spec_helper'

describe "PostIdShow" do
  before(:each) do
	#@post = Post.create(:title => "sujet", :body => "bla bla")
		@post = Post.create(:title => "sujet", :body => "cacahuete")
		@comments = [Comment.create(:author => "auteur", :body => 'commentaire bla bla bla', :post_id => @post.id)]
		@post.comments = @comments

  end
  describe "GET /posts/:id" do
	it "affichagePost" do
		get "/posts/#{@post.id}" 
		response.status.should be(200)
		response.body.should include(@post.title)
		response.body.should include(@post.body)	
	end
	it "link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Back', :href => posts_path)
	end
        it "back link should take to the right pages" do
	    visit "/posts/#{@post.id}"
 	    page.click_link("Back")
	    current_path.should eq posts_path
        end
	it "should have the list of the comments" do
		visit "/posts/#{@post.id}"
		page.body.should include(@post.comments[0].author)
		page.body.should include(@post.comments[0].body)
	end
	it "link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Add a comment', :href => new_post_comment_path(@post.id))
	end
	it "link should exist" do
		visit "/posts/#{@post.id}"
		page.should have_link('Edit', :href => edit_post_path(@post.id))
	end
        it "edit link should take to the right pages" do
	    visit "/posts/#{@post.id}"
 	    page.click_link("Edit")
	    current_path.should eq edit_post_path(@post.id)
        end	
  end
end


