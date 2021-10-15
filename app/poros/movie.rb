class Movie
  attr_reader :genres, :title, :vote_average, :summary

  def initialize(data)
    @genres = data[:genres]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @summary = data[:summary]
    @runtime = data[:runtime]
  end

  def format_runtime
    "#{@runtime/60}:#{@runtime%60}"
  end

end
