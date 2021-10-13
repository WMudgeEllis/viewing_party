require 'rails_helper'

RSpec.describe 'Login page' do
  before(:each) do
    @user = User.create!(email: "sunlesskhan", password: "flipreset")
  end

  it 'logs in with successsful credentials' do
    visit login_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Login Successful")
  end

  it 'does not allow user to login with invalid credentials' do
    visit login_path

    fill_in :email, with: @user.email
    fill_in :password, with: "Yeet"

    click_on  "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid credentials. Please try again.")
  end
end
