class ShowingsController < ApplicationController
  before_action :require_user

  def new
    @movie = Movie.new(params)
    @showing = Showing.new
    @friends = current_user.friends
  end

  def create
    new_showing = Showing.new(showing_params)
    friends = params.keys.filter_map { |key| User.find_by(email: key) }
    if new_showing.save
      current_user.user_showings.create!(showing: new_showing, user_hosting: true)
      friends.each { |friend| friend.user_showings.create!(showing: new_showing, user_hosting: false) }
      flash[:alert] = 'Your viewing party has been created!'
    else
      flash[:error] = 'Oops, something went wrong, please try again'
    end
    redirect_to dashboard_path
  end

  private

  def showing_params
    params.require(:showing).permit(:movie_title, :duration, :day, :start_time)
  end
end
