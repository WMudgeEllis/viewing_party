class MovieService
  def self.get_top_rated_movies(page)
    response = conn.get("/3/movie/top_rated") do |f|
      f.params['page'] = page
    end
    parse_json(response)[:results]
  end

#facade?
  def self.top_40_movies
    get_top_rated_movies(1) + get_top_rated_movies(2)
  end

  def self.search_movie_by_title(title)
    response = conn.get("/3/search/movie?query=#{title}")
    parse_json(response)
  end

  def self.movie_info(movie_id)
    response = Faraday.get(URL + movie_id, { api_key: ENV['movie_key'] })
   JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new("https://api.themoviedb.org") do |f|
      f.params['api_key'] = ENV['movie_key']
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
