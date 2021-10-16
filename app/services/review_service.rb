class ReviewService < Service
  def self.reviews(movie_id)
    parse_json(movie_id)[:results].map { |review| Review.new(review) }
  end

  def self.parse_json(movie_id)
    response = Faraday.get("#{URL+movie_id}/reviews", {api_key: ENV['movie_key']})
    JSON.parse(response.body, symbolize_names: true)
  end
end
