require 'rails_helper'

RSpec.describe 'user dashboard page' do

  before :each do
    @user = User.create!(email: "sunlesskhan", password: "flipreset")
  end

  it 'can log out' do
    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on  "Login"

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You have been logged out')
  end

end
