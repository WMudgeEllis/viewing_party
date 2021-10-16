require "rails_helper"

RSpec.describe ReviewService do

  it 'can fetch review info' do
    expect(ReviewService.reviews('278')).to be_a(Array)
    expect(ReviewService.reviews('278').length).to eq(7)
    expect(ReviewService.reviews('278').first).to be_a(Review)
    expect(ReviewService.reviews('278').first.name).to eq("elshaarawy")
  end

end
