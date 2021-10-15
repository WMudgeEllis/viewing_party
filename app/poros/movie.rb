class Movie
  attr_reader :genres, :title, :vote_average, :summary

  def initialize(data)
    @genres = data[:genres]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @summary = data[:summary]
  end


end
