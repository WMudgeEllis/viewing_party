class MoviesController < ApplicationController
  before_action :require_user

  def index
    # logic to display one outcome
    @movies = if params[:query].present?
                MoviesFacade.search_by_title(params[:query])
              else
                MoviesFacade.top_40_movies
              end
  end

  def show
    @movie = Movie.new(MovieService.movie_info(params[:id]))
    @cast = MoviesFacade.first_10_cast(params[:id])
    @reviews = MoviesFacade.reviews(params[:id])
  end
end
