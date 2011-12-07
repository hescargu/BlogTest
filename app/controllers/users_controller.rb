class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      redirect_to new_session_path, :notice => "Signed up!"
    else
      redirect_to new_user_path
    end
  end
end
