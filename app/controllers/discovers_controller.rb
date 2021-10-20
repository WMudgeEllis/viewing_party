class DiscoversController < ApplicationController

  def index
    @movies = if params[:query].present?
                MoviesFacade.search_by_title(params[:query])
              else
                MoviesFacade.top_40_movies
              end
  end

  def show
    @movies = if params[:query].present?
                MoviesFacade.search_by_title(params[:query])
              else
                MoviesFacade.top_40_movies
              end
  end 
end
