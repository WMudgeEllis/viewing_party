class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def login
    user = User.find_by(email: params[:email])
    # require "pry"; binding.pry
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Login Successful"
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid credentials. Please try again."
      redirect_to root_path
    end
  end

  def login_form
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
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end


end
