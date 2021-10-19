require "faraday"

class APIService
  URL = 'https://api.themoviedb.org/3/movie/'.freeze

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['movie_key']
    end
  end
end
