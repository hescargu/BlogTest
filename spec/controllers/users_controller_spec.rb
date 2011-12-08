require 'spec_helper'

describe UsersController do

	describe "new" do
		before(:each) do
			@user = stub_model(User,:email => " ", :password => " ", :password_confirmation => " ")
			@user2 = stub_model(User,:email => "sujet2", :body => "rfhergzb")
			@users = [@user2]
			#change le résultat de user.new
			User.stub(:new) { @user }
		end
		it "New doit retourner un user" do
			User.should_receive(:new).and_return(@user)
			#appel de l'action du controller
			get :new
			#doit affecter la variable @user
			assigns(:user).should eq @user
		end
	end

	describe "create" do
		before(:each) do
			@user = stub_model(User,:email => "someone@something.com", :password => "rfhergzb", :password_confirmation =>  "rfhergzb")
			@user_params = {"user" => { "email" => "user_email", "password" => "user_password", "password_confirmation" => "user_password"}}
			@users = [@user]
			User.stub(:create) { @user }
			User.stub(:save) { true }
		end
		it "create doit retourner un user" do
			User.should_receive(:create).with(@user_params["user"]).and_return(@user)	
			@user.should_receive(:save).and_return("true")		
			post :create, @user_params
			response.should redirect_to(posts_path)
		end
	end

	describe "destroy" do
	    before(:each) do
	      @user = stub_model(User, :email => "someone@something.com", :password => "rfhergzb", :password_confirmation =>  "rfhergzb")
	      @user.stub(:destroy){ true }
	      User.stub(:find){ @user }
		controller.stub!(:require_user).and_return(true)
	    end
	    it "should redirect to the posts list" do
	      delete :destroy, {:id => @user.id }
	      response.should redirect_to posts_path
	    end

	    it "should search the post" do
	      User.should_receive(:find).with(@user.id.to_s).and_return(@user)
	      delete :destroy, {:id => @user.id }
	    end

	    it "should destroy the post" do
	      @user.should_receive(:destroy)
	      delete :destroy, {:id => @user.id }
	    end
	end
end
