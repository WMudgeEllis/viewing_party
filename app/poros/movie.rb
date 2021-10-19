class Movie
  attr_reader :genres, :title, :vote_average, :overview, :runtime, :id

  def initialize(data)
    @genres = data[:genres]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @overview = data[:overview]
    @runtime = data[:runtime]
    @id = data[:id]
  end

  def format_runtime
    "#{@runtime / 60}:#{@runtime % 60}"
  end
end
