class MoviesFacade
  def self.reviews(movie_id)
    ReviewService.review_info(movie_id)[:results].map { |review| Review.new(review) }
  end

  def self.first_10_cast(movie_id)
    CastService.cast_info(movie_id)[:cast].map { |cast| CastMember.new(cast) }[0..9]
  end

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
