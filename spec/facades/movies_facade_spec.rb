require "rails_helper"

RSpec.describe MoviesFacade do

  it 'can make review objects', :vcr do
    result = MoviesFacade.reviews('238')

    expect(result).to be_a(Array)
    expect(result.first).to be_a(Review)
  end

  it 'can make cast objects', :vcr do
    result = MoviesFacade.first_10_cast('238')

    expect(result).to be_a(Array)
    expect(result.first).to be_a(CastMember)
  end

  it 'returns the correct number of movies', :vcr do
    expect(MoviesFacade.top_40_movies.count).to eq(40)
  end
end
