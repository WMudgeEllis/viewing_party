class MoviesController < ApplicationController
  before_action :require_user

  def index
    if params[:query].present?
      @search = APIS::MoviesFacade.search_by_title(params[:query])
    elsif params[:query].nil?
      @movies = APIS::MoviesFacade.top_40_movies
    end
  end

  def show
    @movie = Movie.new(MovieService.movie_info(params[:id]))
    @cast = CastService.first_10_cast(params[:id])
    @reviews = ReviewService.reviews(params[:id])
  end
end
