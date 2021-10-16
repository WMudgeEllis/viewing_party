require "rails_helper"

RSpec.describe 'new showing page' do
  before :each do
    @user = User.create!(email: "sunlesskhan@kahn.com", password: "flipreset")
    @user2 = User.create!(email: "scar@sa.net", password: "face")
    @user3 = User.create!(email: "balderdash@yada.com", password: "123")
    @user.friendships.create!(friend_id: @user2.id)
    @user.friendships.create!(friend_id: @user3.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/movies/1667'
    click_button 'Create Viewing Party'
  end

  it 'has default data', :vcr do
    expect(page).to have_content('March of the Penguins')
    expect(page).to have_content(@user2.email)
    expect(page).to have_content(@user3.email)
  end

  it 'cant create a showing without friends', :vcr do
    fill_in 'showing[day]', with: '1/3/1993'
    fill_in 'showing[start_time]', with: '1800'

    click_button 'Create'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('March of the Penguins')
  end
end
