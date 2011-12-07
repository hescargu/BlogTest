require 'spec_helper'

describe User do


  context "A user (in general)" do

    before(:each) do
      @user = User.new
    end

    specify "should be invalid without an email" do
      @user.password = 'abcdefg'
      @user.password_confirmation = 'abcdefg'
      @user.should_not be_valid
      @user.email = 'someone@something.com'
      @user.should be_valid
    end

    specify "should be invalid without an email" do
      @user.password = 'abcdefg'
      @user.password_confirmation = 'abcdefg'
      @user.should_not be_valid
      @user.email = 'someone@something.com'
      @user.should be_valid
    end

    specify "should be invalid without a password" do
      @user.email = 'someone@something.com'
      @user.should_not be_valid
      @user.password = 'abcdefg'
      @user.password_confirmation = 'abcdefg'
      @user.should be_valid
    end
    specify "should be invalid if password is not between 6 and 12 characters in length" do
      @user.email = 'someone@something.com'
      @user.password = 'abcdefghijklm'
      @user.password_confirmation = 'abcdefghijklm'
      @user.should_not be_valid
      @user.password = 'abcde'
      @user.password_confirmation = 'abcde'
      @user.should_not be_valid
      @user.password = 'abcdefg'
      @user.password_confirmation = 'abcdefg'
      @user.should be_valid
    end
  end
end

