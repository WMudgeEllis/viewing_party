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

  it 'has the button to render the top 40 movie button', :vcr do
    expect(page).to have_button('Find Top Rated Movies')
  end
end
