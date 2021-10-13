require "rails_helper"

RSpec.describe 'new user registration page' do

  before(:each) do
    @email = 'funkypop@aol.com'
    @password = 'hunter1'

    visit registration_path
  end

  it 'can make a new user' do
    #wtf, why did this happen?
    fill_in 'user[email]', with: @email
    fill_in 'user[password]', with: @password
    fill_in 'user[confirm_password]', with: @password

    click_on 'Register'

    user = User.last

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user.email)
  end

  it 'can confirm the passwords' do
    #wtf, why did this happen?
    fill_in 'user[email]', with: @email
    fill_in 'user[password]', with: @password
    fill_in 'user[confirm_password]', with: 'wrong password'

    click_on 'Register'

    expect(current_path).to eq(registration_path)
    expect(page).to have_content('Please ensure that the passwords match')
  end

  it 'can stop duplicate emails' do
    User.create!(email: @email, password: 'throw away')

    fill_in 'user[email]', with: @email
    fill_in 'user[password]', with: @password
    fill_in 'user[confirm_password]', with: @password

    click_on 'Register'

    expect(current_path).to eq(registration_path)
    expect(page).to have_content('Email has already been taken')
  end
end
