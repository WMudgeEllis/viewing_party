require "rails_helper"

RSpec.describe CastService do

  it 'can make cast members', :vcr do
    expect(CastService.cast_info('238')[:cast]).to be_a(Array)
    expect(CastService.cast_info('238')[:cast].first).to be_a(Hash)
    expect(CastService.cast_info('238')[:cast].first).to have_key(:name)
    expect(CastService.cast_info('238')[:cast].first[:name]).to be_a(String)
    expect(CastService.cast_info('238')[:cast].first).to have_key(:character)
    expect(CastService.cast_info('238')[:cast].first[:character]).to be_a(String)
  end

end
