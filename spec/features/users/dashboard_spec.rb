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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      expect(page).to_not have_content(@user2.email)
      expect(@user.friends).to eq([])

      within('#friend-search') do
        fill_in :find_friend, with: @user2.email
        click_button "Add"
      end

      @user.reload
      refresh
      expect(@user.friends).to eq([@user2])
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(@user2.email)

    end

    it 'shows message when friends list is empty' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      message = "You don't have any friends. Add one!"

      visit dashboard_path

      expect(page).to have_content(message)
    end

    it 'makes sure only authenticated users can access dashboard' do
      visit dashboard_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('please log in or create an account')
    end

    it 'can fail to find a friend' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

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
      @showing = Showing.create!(movie_title: 'star warz', duration: 120, day: '1/2/1993', start_time: '1800', movie_id: 1667)
      @showing2 = Showing.create!(movie_title: 'return of the star warz', duration: 120, day: '3/9/2018', start_time: '0800', movie_id: 238)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can show all viewing parties invited' do
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

    it 'can show invited users' do
      UserShowing.create!(user: @user, showing: @showing, user_hosting: true)
      UserShowing.create!(user: @user2, showing: @showing, user_hosting: false)
      UserShowing.create!(user: @user3, showing: @showing, user_hosting: false)

      visit dashboard_path

      within("#showing-#{@showing.id}-invited") do
        expect(page).to_not have_content(@user.email)
        expect(page).to have_content(@user2.email)
        expect(page).to have_content(@user3.email)
      end
    end

    it 'links to movie show page', :vcr do
      UserShowing.create!(user: @user, showing: @showing, user_hosting: true)
      visit dashboard_path

      expect(page).to have_link(@showing.movie_title)

      click_link @showing.movie_title

      expect(current_path).to eq("/movies/#{@showing.movie_id}")
    end

    it 'has a button to go to discover movies page', :vcr do
      visit dashboard_path

      click_on "Discover Movies"

      expect(current_path).to eq(discover_path)
    end

    it 'redirects to dashboard if logged in' do
      visit root_path

      expect(current_path).to eq(dashboard_path)

    end

    it 'dosent allow user to add themselves' do
      visit dashboard_path

      fill_in :find_friend, with: @user.email
      click_on "Add"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("You can't add yourself as a friend!")
    end

    it 'dosent allow users to add duplicate friends' do
      visit dashboard_path

      @user.friendships.create!(friend_id: @user2.id)

      fill_in :find_friend, with: @user2.email
      click_on "Add"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("This user is already your friend.")
    end
  end
end
