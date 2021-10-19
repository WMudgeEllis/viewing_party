require 'rails_helper'

RSpec.describe 'discover page' do
  before(:each) do
    @user = User.create!(email: "Johnny", password: "Knoxville")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit discover_path
  end

  it 'renders page with no error', :vcr do
    expect(page.status_code).to eq(200)
  end

  it 'shows a button to go to the movies page', :vcr do
    click_button("Find Top Rated Movies")
    expect(current_path).to eq(movies_path)
  end
end
