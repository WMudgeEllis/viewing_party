require 'rails_helper'

RSpec.describe 'user dashboard page' do

  describe 'logout and friend functionality' do
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

  describe 'showing functionality' do
    before :each do
      @user = User.create!(email: "sunlesskhan@kahn.com", password: "flipreset")
      @user2 = User.create!(email: "scar@sa.net", password: "face")
      @user3 = User.create!(email: 'sleeps@zz.com', password: 'yawn')
      @user4 = User.create!(email: 'wakefull@dud.com', password: 'coffee')
      @showing = Showing.create!(movie_title: 'star warz', duration: 120, day: '1/2/1993', start_time: '1800')
      @showing2 = Showing.create!(movie_title: 'return of the star warz', duration: 120, day: '3/9/2018', start_time: '0800')
    end

    it 'can show all viewing parties invited' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      UserShowing.create!(user: @user, showing: @showing, user_hosting: false)
      UserShowing.create!(user: @user, showing: @showing2, user_hosting: false)
      UserShowing.create!(user: @user2, showing: @showing, user_hosting: true)
      UserShowing.create!(user: @user2, showing: @showing2, user_hosting: true)
      visit dashboard_path

      expect(page).to have_content(@showing.movie_title)
      expect(page).to have_content(@showing.day)
      expect(page).to have_content(@showing.start_time)
      expect(page).to have_content(@showing2.movie_title)
      expect(page).to have_content(@showing2.day)
      expect(page).to have_content(@showing2.start_time)
    end

    it 'can show host of party' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      UserShowing.create!(user: @user, showing: @showing, user_hosting: false)
      UserShowing.create!(user: @user2, showing: @showing, user_hosting: true)
      UserShowing.create!(user: @user, showing: @showing2, user_hosting: true)

      visit dashboard_path

      within("#showing-#{@showing.id}") do
        expect(page).to have_content("Host: #{@user2.email}")
      end

      within("#showing-#{@showing2.id}") do
        expect(page).to have_content("Host: #{@user.email}")
      end

    end
  end
end
