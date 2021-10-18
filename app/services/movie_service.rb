class MovieService < Service
  def self.movie_info(movie_id)
    response = Faraday.get(URL + movie_id, { api_key: ENV['movie_key'] })
    json_parse(response)
  end
end
