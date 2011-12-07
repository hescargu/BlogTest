require 'spec_helper'

describe Post do

context "A post (in general)" do

    before(:each) do
      @post = Post.new
    end

    specify "should be invalid without a title" do
      @post.body = 'abcdefg'
      @post.should_not be_valid
      @post.title = 'Titre du post'
      @post.should be_valid
    end

    specify "should be invalid without a body" do
      @post.title = 'Titre du post'
      @post.should_not be_valid
      @post.body = 'abcdefg'
      @post.should be_valid
    end

    specify "should be invalid if title is not between 2 and 30 characters in length" do
      @post.title = 'a'
      @post.body = 'body'
      @post.should_not be_valid
      @post.title = 'abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890'
      @post.should_not be_valid
      @post.title = 'abcdefg'
      @post.should be_valid
    end

    specify "should be invalid if body is not between 2 and 500 characters in length" do
      @post.body = 'a'
      @post.title = 'Titre du post'
      @post.should_not be_valid
      @post.body = 'abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890'
      @post.should_not be_valid
      @post.body = 'body'
      @post.should be_valid
    end
  end
end
