require 'rails_helper'

RSpec.describe 'discover page' do
  before(:each) do
    @user = User.create!(email: "Johnny", password: "Knoxville")
    visit discover_path
  end

  it 'shows a button to go to the movies page' do
    expect(page).to have_button("Find Top Rated Movies")
    click_button("Find Top Rated Movies")
    expect(current_path).to eq(movies_path)
  end
end
