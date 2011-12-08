class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      session[:user_id]=@user.id
      redirect_to posts_path, :notice => "Signed up!"
    else
      flash[:error] = "Email has already been taken"
      render "new"
    end
  end
  def destroy
	@user = User.find(params[:id])
	@user.destroy
	session[:user_id]=nil
    	respond_to do |format|
      		format.html { redirect_to posts_path, notice: 'Your account was successfully deleted.'}
      		format.js
	end
  end
end
