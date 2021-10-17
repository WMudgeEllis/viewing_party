class CastService < Service
  def self.first_10_cast(movie_id)
    cast_info(movie_id)[:cast].map { |cast| CastMember.new(cast) }[0..9]
  end

  def self.cast_info(movie_id)
    response = Faraday.get("#{URL + movie_id}/credits", { api_key: ENV['movie_key'] })
    JSON.parse(response.body, symbolize_names: true)
  end
end
