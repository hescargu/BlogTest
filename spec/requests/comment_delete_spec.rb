require 'spec_helper'

describe "DeleteComments" do
pending 'probleme link delete ...'
  describe "GET /posts/:id_post" do
    before(:each) do
	@post = Post.create(:title => "sujet", :body => "cacahuete")
	@post.comments.create(:author => "auteur", :body => "commentaire")
#      @post = Post.create(:title => "sujet", :body => "cacahuete")
#      @posts = [@post]
#      @comment = Comment.create(:author => "auteur", :body => "commentaire", :post_id => @post.id)
#      @comments = [@comment]
    end
    describe "a comment in the list" do
      it "should have a delete button" do
        get post_path(@post)
        #page.should have_link("Delete Comment", "/posts/#{@post.id}/comments/#{@post.comments[0].id}")
      end
    end
    describe "after a click on the delete link on the 2nd post" do
      it "should display the list without the post2" do
	 get post_path(@post)
       	 #click_link("Delete Comment")
         #current_path.should == post_path(@post)
         #page.should_not have_content(@post.comments[0].body)
      end
    end
  end
end
