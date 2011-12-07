require 'spec_helper'

describe "DeleteComments" do
  describe "GET /posts/:id_post" do
    before(:each) do
	@post = Post.create(:title => "sujet", :body => "cacahuete")
	@post.comments = [Comment.create(:author => "auteur", :body => "commentaire")]
    end
    describe "a comment in the list" do
      it "should have a delete link" do
        visit post_path(@post)
        page.should have_link("Delete Comment")
      end
    end
    describe "after a click on the delete link on the 2nd post" do
      it "should display the list without the post2" do
	 visit post_path(@post)
       	 click_link("Delete Comment")
         current_path.should == post_path(@post)
         page.should_not have_content(@post.comments[0].body)
      end
    end
  end
end
