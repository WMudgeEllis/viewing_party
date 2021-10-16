require "rails_helper"

RSpec.describe Review do
  it 'can have basic attributes', :vcr do
    data = {
            author: "tmdb73913433",
            content: "Make way for the best film ever made people. **Make way.**"
    }
    review = Review.nea(data)

    expect(review.author).to eq("tmdb73913433")
    expect(review.content).to eq("Make way for the best film ever made people. **Make way.**")
  end
end
