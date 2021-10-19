require "faraday"

class ReviewService < APIService
  def self.review_info(movie_id)
    response = conn.get("#{URL + movie_id}/reviews")
    parse_json(response)
  end
end
