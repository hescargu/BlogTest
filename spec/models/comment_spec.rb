require 'spec_helper'

describe Comment do
  context "A comment (in general)" do

    before(:each) do
      @comment = Comment.new
    end

    specify "should be invalid without an author" do
      @comment.body = 'abcdefg'
      @comment.should_not be_valid
      @comment.author = 'someone'
      @comment.should be_valid
    end

    specify "should be invalid without a body" do
      @comment.author = 'someone'
      @comment.should_not be_valid
      @comment.body = 'abcdefg'
      @comment.should be_valid
    end

    specify "should be invalid if author is not between 2 and 30 characters in length" do
      @comment.author = 'a'
      @comment.body = 'body'
      @comment.should_not be_valid
      @comment.author = 'abcdefghijklmnopqrstuvwxyz1234567890'
      @comment.should_not be_valid
      @comment.author = 'abcdefg'
      @comment.should be_valid
    end

    specify "should be invalid if body is not between 2 and 500 characters in length" do
      @comment.body = 'a'
      @comment.author = 'someone'
      @comment.should_not be_valid
      @comment.body = 'abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890'
      @comment.should_not be_valid
      @comment.body = 'body'
      @comment.should be_valid
    end
  end
end
