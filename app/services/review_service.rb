class ReviewService < Service
  def self.review_info(movie_id)
    response = Faraday.get("#{URL + movie_id}/reviews", { api_key: ENV['movie_key'] })
    json_parse(response)
  end
end
