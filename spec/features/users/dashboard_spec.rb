require 'rails_helper'

RSpec.describe 'user dashboard page' do

  before :each do
    @user = User.create!(email: "sunlesskhan", password: "flipreset")
    @user2 = User.create!(email: "scar", password: "face")
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


  it 'can find a friend' do
    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on  "Login"

    expect(page).to_not have_content(@user2.email)
    expect(@user.friends).to eq([])

    within('#friend-search') do
      fill_in :find_friend, with: @user2.email
      click_button "Add"
    end

    @user.reload
    expect(@user.friends).to eq([@user2])
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(@user2.email)

  end

  it 'shows message when friends list is empty' do
    message = "You don't have any friends. Add one!"
    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on  "Login"

    expect(page).to have_content(message)
  end

  it 'makes sure only authenticated users can access dashboard' do
    visit dashboard_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('please log in or create an account')
  end

  it 'can fail to find a friend' do
    visit root_path

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_on  "Login"

    fill_in :find_friend, with: 'nofriend@sad.com'

    click_button 'Add'

    @user.reload
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('User does not exist')
    expect(@user.friends).to eq([])
  end

end
