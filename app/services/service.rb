class Service
  URL = 'https://api.themoviedb.org/3/movie/'.freeze

  def self.json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
