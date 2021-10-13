require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before(:each) do
    @welcome_message = "Welcome to viewing party! Be sure to grab some extra popcorn."
    @description = "Viewing party is an application that allows you to schedule showings with your friends or anyone you'd like. If you are new here be sure to register with us!"
    @user = User.create!(email: "sunlesskhan", password: "flipreset")
  end

  it 'shows welcome message and description' do
    visit root_path

    expect(page).to have_content(@welcome_message)
    expect(page).to have_content(@description)
  end

  it 'shows a button to register as a new user' do
    visit root_path
    click_on "Register"

    expect(current_path).to eq(registration_path)
  end

  it 'logs the user in' do
    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on "Login"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Login Successful")
  end
end
