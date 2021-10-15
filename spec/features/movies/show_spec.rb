require "rails_helper"


RSpec.describe 'movie show page' do

  before :each do
    @user = User.create!(email: "sunlesskhan@kahn.com", password: "flipreset")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'has a button to new viewing party' do
    visit '/movies/1167'

    expect(page).to have_button('Create Viewing Party')

    click_button 'Create Viewing Party'

    expect(current_path).to eq(new_showing_path)
  end
end
