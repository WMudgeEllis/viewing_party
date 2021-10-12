class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if user_params[:password] != params[:user][:confirm_password]
      flash[:error] = 'Please ensure that the passwords match'
      redirect_to '/registration'
    elsif new_user.save
      session[:id] = new_user.id
      redirect_to '/dashboard'
    end
  end

  def show
    @user = User.find(session[:id])
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
