require "faraday"

class MovieService < APIService
  def self.get_top_rated_movies(page)
    response = conn.get('/3/movie/top_rated') do |f|
      f.params['page'] = page
    end
    parse_json(response)[:results]
  end

  def self.search_movie_by_title(title)
    response = conn.get('/3/search/movie') do |f|
      f.params['query'] = title
    end
    parse_json(response)
  end

  def self.movie_info(movie_id)
    response = conn.get(URL + movie_id)
    parse_json(response)
  end
end
