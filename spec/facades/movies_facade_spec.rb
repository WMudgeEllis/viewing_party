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
    expect(result.length).to eq(10)
    expect(result.first).to be_a(CastMember)
  end

  it 'can get top_40_movies', :vcr do
    result = MoviesFacade.top_40_movies
    
    expect(result).to be_a(Array)
    expect(result.first).to be_a(Movie)
  end

  it 'can search_by_title', :vcr do
    result = MoviesFacade.search_by_title('The Godfather')

    expect(result).to be_a(Array)
    expect(result.first).to be_a(Movie)
    expect(result.first.title).to eq('The Godfather')
  end
end
