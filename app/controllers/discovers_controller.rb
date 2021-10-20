class DiscoversController < ApplicationController
  before_action :require_user
  def show
    @movies = MoviesFacade.top_40_movies
  end
end
