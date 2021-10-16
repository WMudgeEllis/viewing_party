require "rails_helper"

RSpec.describe CastService do

  it 'can make cast members', :vcr do
    expect(CastService.first_10_cast('238')).to be_a(Array)
    expect(CastService.first_10_cast('238').length).to eq(10)
    expect(CastService.first_10_cast('238').first).to be_a(CastMember)
  end

end
