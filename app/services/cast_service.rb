class CastService < Service
  def self.cast_info(movie_id)
    response = Faraday.get("#{URL + movie_id}/credits", { api_key: ENV['movie_key'] })
    json_parse(response)
  end
end
