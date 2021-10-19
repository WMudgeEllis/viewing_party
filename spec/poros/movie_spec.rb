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
      overview: '12345',
      id: '123'
    }
    movie = Movie.new(data)

    expect(movie.genres).to eq([{id: 123, name: 'Documentary'}])
    expect(movie.title).to eq('Hola')
    expect(movie.overview).to eq('12345')
    expect(movie.vote_average).to eq(1.3)
    expect(movie.format_runtime).to eq('2:10')
    expect(movie.id).to eq('123')
  end
end
