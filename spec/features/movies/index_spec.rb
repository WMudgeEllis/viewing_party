require 'rails_helper'

RSpec.describe 'movies index page' do
  before(:each) do
    @user = User.create(email: "hello", password: "world")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit movies_path
  end

  it 'visits the page with no errors', :vcr do
    expect(page.status_code).to eq(200)
  end

  it 'has the movies title and rating', :vcr do
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to have_content("8.7")
  end

  it 'has a link of each movie title to its show page', :vcr do
    click_link "The Shawshank Redemption"
    expect(current_path).to eq("/movies/278")
  end

  it 'can search for a movie and go to its showpage', :vcr do
    within('#movie-search') do
      fill_in :query, with: "Goodfellas"
      click_button "Search"
    end

    expect(page).to have_content("Goodfellas")

    click_link "Goodfellas"

    expect(current_path).to eq("/movies/696842")
  end
end
