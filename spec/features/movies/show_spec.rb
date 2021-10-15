require "rails_helper"


RSpec.describe 'movie show page' do

  it 'has a button to new viewing party' do
    visit '/movies/1167'

    expect(page).to have_button('Create Viewing Party')

    click_button 'Create Viewing Party'

    expect(current_path).to eq(new_showing_path)
  end
end
