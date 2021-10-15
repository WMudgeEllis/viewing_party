require "rails_helper"

RSpec.describe Movie do

  it 'can recieve data' do
    data = {
      genres: [
        {
          id: 123,
          name: 'Documentary'
        }
      ],
      title: 'Hola',
      vote_average: 1.3,
      runtime: 130,
      summary: '12345'
    }
    movie = Movie.new(data)

    expect(movie.genres).to eq([{id: 123, name: 'Documentary'}])
    expect(movie.title).to eq('Hola')
    expect(movie.summary).to eq('12345')
    expect(movie.runtime).to eq(130)
    expect(movie.vote_average).to eq(1.3)
  end
end
