require "rails_helper"


RSpec.describe 'movie show page' do

  before :each do
    @user = User.create!(email: "sunlesskhan@kahn.com", password: "flipreset")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/movies/1667'
  end

  it 'has a button to new viewing party', :vcr do
    expect(page).to have_button('Create Viewing Party')

    click_button 'Create Viewing Party'

    expect(current_path).to eq(new_showing_path)
  end

  it 'has movie details', :vcr do
    expect(page).to have_content('March of the Penguins')
    expect(page).to have_content('Vote Average: 7.0')
    expect(page).to have_content('Runtime: 1:20')
    expect(page).to have_content('Genres: Documentary, Family')
    expect(page).to have_content("Every year, thousands of Antarctica's emperor")
  end

  it 'has reviews', :vcr do
    expect(page).to have_content('Number of reviews: 0')
    expect(page).to have_content('No reviews')
  end

  it 'has cast information', :vcr do
    expect(page).to have_content('Morgan Freeman/Narrator')
    expect(page).to have_content('Charles Berling/Father Penguin (french voice)')
  end
end
