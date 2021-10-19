
class CastService < APIService
  def self.cast_info(movie_id)
    response = conn.get("#{URL + movie_id}/credits")
    parse_json(response)
  end
end
