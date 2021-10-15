class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if user_params[:password] != params[:user][:confirm_password]
      flash[:error] = 'Please ensure that the passwords match'
    elsif new_user.save
      session[:user_id] = new_user.id
      return redirect_to '/dashboard'
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
    end
    redirect_to registration_path
  end

  def show
    require_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
