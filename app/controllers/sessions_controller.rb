class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Login Successful'
      redirect_to dashboard_path
    else
      flash[:error] = 'Invalid credentials. Please try again.'
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:sucess] = 'You have been logged out'
    redirect_to root_path
  end
end
