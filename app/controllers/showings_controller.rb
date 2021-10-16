class ShowingsController < ApplicationController
  before_action :require_user

  def new
    @movie = Movie.new(params)
    @showing = Showing.new
    @friends = current_user.friends
  end

  def create
    new_showing = Showing.new(showing_params)

    if new_showing.save
      current_user.user_showings.create!(showing: new_showing, user_hosting: true)
      redirect_to dashboard_path
    end

  end

  private

  def showing_params
    params.require(:showing).permit(:movie_title, :duration, :day, :start_time)
  end
end
