class UsersController < ApplicationController
  def new
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successful"
      redirect_to root_path
    else
      flash[:error] = "Invalid credentials. Please try again."
      render :login_form
    end
  end

  def login_form
  end
end
