require "rails_helper"

RSpec.describe MovieService do

  it 'can get movie title with movie id', :vcr do
    title = "March of the Penguins"
    data = MovieService.movie_info('1667')
    expect(data[:title]).to eq(title)
    expect(data[:genres].class).to eq(Array)
    expect(data[:genres].length).to eq(2)
    expect(data[:runtime]).to eq(80)
    expect(data[:overview].class).to eq(String)
    expect(data[:vote_average]).to eq(7.0)
  end

  it 'returns different movies for each page', :vcr do
    expect(MovieService.get_top_rated_movies(1)).to_not eq(MovieService.get_top_rated_movies(2))
  end
end
