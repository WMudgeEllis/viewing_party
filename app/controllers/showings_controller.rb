class ShowingsController < ApplicationController
  before_action :require_user

  def new
    @movie = Movie.new(params)
    @showing = Showing.new
    @friends = current_user.friends
  end

  def create
    new_showing = Showing.new(showing_params)
    friends = User.find_by_email(params.keys)
    if showing_params[:duration] < params[:showing][:movie_runtime]
      flash[:error] = "Party duration can't be less than the movie runtime"
    elsif new_showing.save
      create_user_showings(new_showing, friends)
    else
      flash[:error] = 'Oops, something went wrong, please try again'
    end
    redirect_to dashboard_path
  end

  private

  def create_user_showings(new_showing, friends)
    current_user.user_showings.create!(showing: new_showing, user_hosting: true)
    friends.each do |friend|
      friend.user_showings.create!(showing: new_showing, user_hosting: false)
    end
    flash[:alert] = 'Your viewing party has been created!'
  end

  def showing_params
    params.require(:showing).permit(:movie_title, :duration, :day, :start_time, :movie_id)
  end
end
