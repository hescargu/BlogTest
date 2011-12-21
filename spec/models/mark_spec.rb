require 'spec_helper'

describe Mark do
  context "A mark (in general)" do

    before(:each) do
      @mark = Mark.new
    end
    specify "should be invalid without a value" do
      @mark.post_id = 1
      @mark.should_not be_valid
      @mark.value = 3
      @mark.should be_valid
    end
    specify "should be invalid without a post_id" do
      @mark.value = 3
      @mark.should_not be_valid
      @mark.post_id = 1
      @mark.should be_valid
    end
    specify "should be invalid with a bad format" do
      @mark.value = 34
      @mark.post_id = 1
      @mark.should_not be_valid
      @mark.value = 3
      @mark.should be_valid
    end
  end
end
