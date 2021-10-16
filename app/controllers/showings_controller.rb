class ShowingsController < ApplicationController
  before_action :require_user

  def new
    @movie = Movie.new(params)
    @showing = Showing.new
    @friends = current_user.friends
  end
end
