require 'spec_helper'

describe SessionsController do

	describe "create" do
		before(:each) do
			@user = stub_model(User,:email => "user_email", :password => "user_password", :password_confirmation => "user_password")
			@users = [@user]
			@user_recherche = stub_model(User, :email => "user_email", :password => "user_password", :password_confirmation => "user_password")
			User.stub(:find_by_email) { @user }
			User.stub(:authenticate) { true }
			session[:user_id] = nil
		end
		it "create doit retourner une session" do
			User.should_receive(:find_by_email).with(@user_recherche.email).and_return(@user)
			@user.should_receive(:authenticate).with(@user_recherche.password).and_return(true)
			session[:user_id].should be_nil
			post :create, {:email => @user_recherche.email, :password => @user_recherche.password}
			session[:user_id].should_not be_nil
			response.should redirect_to(posts_path)
		end
	end

	describe "destroy" do
	    before(:each) do
		@user = stub_model(User,:email => "user_email", :password => "user_password", :password_confirmation => "user_password")
		@users = [@user]
		session[:user_id] = @user.id
	    end
	    it "should redirect to the posts list" do
	      delete :destroy, {:id => @user.id}
	      response.should redirect_to posts_path
	    end

	    it "should destroy the session" do
	      session[:user_id].should_not be_nil
    	      delete :destroy, { :id => @user.id }
	      session[:user_id].should be_nil
	    end


	end
end


