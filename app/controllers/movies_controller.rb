class MoviesController < ApplicationController
  before_action :require_user

  def index; end

  def show
    @movie = Movie.new(MovieService.movie_info(params[:id]))
    @cast = CastService.first_10_cast(params[:id])
    @reviews = ReviewService.reviews(params[:id])
  end
end
