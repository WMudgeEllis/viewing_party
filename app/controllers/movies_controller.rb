class MoviesController < ApplicationController
  before_action :require_user

  def index; end

  def show
    @movie = Movie.new(MovieService.movie_info(params[:id]))
    @cast = MoviesFacade.first_10_cast(params[:id])
    @reviews = MoviesFacade.reviews(params[:id])
  end
end
