module APIS
  class MoviesFacade
    def self.top_40_movies
      movies = MovieService.top_40_movies

      movies.map do |movie|
        Movie.new(movie)
      end
    end

    def self.search_by_title(title)
      service = MovieService.search_movie_by_title(title)

      service[:results].map do |movie|
        MovieResult.new(movie)
      end
    end
  end
end
