require "rails_helper"

RSpec.describe ReviewService do

  it 'can fetch review info' do
    VCR.use_cassette('movie_reviews', re_record_interval: 1.days) do
      expect(ReviewService.review_info('278')[:results]).to be_a(Array)

      expect(ReviewService.review_info('278')[:results].first).to have_key(:author)
      expect(ReviewService.review_info('278')[:results].first[:author]).to be_a(String)
      expect(ReviewService.review_info('278')[:results].first).to have_key(:content)
      expect(ReviewService.review_info('278')[:results].first[:content]).to be_a(String)
    end
  end

end
