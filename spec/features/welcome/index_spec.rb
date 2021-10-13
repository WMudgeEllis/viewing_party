require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before(:each) do
    @welcome_message = "Welcome to viewing party! Be sure to grab some extra popcorn."
    @description = "Viewing party is an application that allows you to schedule showings with your friends or anyone you'd like. If you are new here be sure to register with us!"
    @user = User.create!(email: "sunlesskhan", password_digest: "flipreset")
  end

  it 'shows welcome message and description' do
    visit root_path

    expect(page).to have_content(@welcome_message)
    expect(page).to have_content(@description)
  end

  xit 'shows a button to register as a new user' do
    visit root_path
    click_on "Register"

    expect(current_path).to eq(new_user_path)
  end

  it 'shows a button to login' do
    visit root_path
    click_on "Login"

    expect(current_path).to eq(login_path)
  end
end
