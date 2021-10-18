class MoviesFacade

  def self.reviews(movie_id)
    ReviewService.review_info(movie_id)[:results].map { |review| Review.new(review) }
  end

  def self.first_10_cast(movie_id)
    CastService.cast_info(movie_id)[:cast].map { |cast| CastMember.new(cast) }[0..9]
  end

end
