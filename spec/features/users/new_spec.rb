require "rails_helper"

RSpec.describe 'new user registration page' do
  it 'can make a new user' do
    visit new_users_path

    email = 'funkypop@aol.com'
    password = 'hunter1'

    fill_in user_email, with: email
    fill_in user_password, with: password
    fill_in user_password_confirmation, with: password

    click_on 'Create Account'

    user = User.last

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("#{user.email}")
  end
end
