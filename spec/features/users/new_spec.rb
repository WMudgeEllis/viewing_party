require "rails_helper"

RSpec.describe 'new user registration page' do
  it 'can make a new user' do
    visit '/registration'

    email = 'funkypop@aol.com'
    password = 'hunter1'

    #wtf, why did this happen?
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[confirm_password]', with: password

    click_on 'Register'

    user = User.last

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("#{user.email}")
  end

  it 'can confirm the passwords' do
    visit '/registration'

    email = 'funkypop@aol.com'
    password = 'hunter1'

    #wtf, why did this happen?
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[confirm_password]', with: 'hunter2'

    click_on 'Register'

    expect(current_path).to eq('/registration')
    expect(page).to have_content('Please ensure that the passwords match')
  end
end
