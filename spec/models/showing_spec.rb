require 'rails_helper'

RSpec.describe Showing do
  describe 'relationships' do
    it {should have_many(:user_showings)}
    it {should have_many(:users).through(:user_showings)}
  end
  describe 'validations' do
    it {should validate_presence_of(:movie_title)}
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:day)}
    it {should validate_presence_of(:start_time)}
    it {should validate_presence_of(:movie_id)}
    
  end

  before :each do
    @user = User.create!(email: "sunlesskhan@kahn.com", password: "flipreset")
    @user2 = User.create!(email: "scar@sa.net", password: "face")
    @user3 = User.create!(email: "balderdash@yada.com", password: "123")
    @showing = Showing.create!(movie_title: 'star warz', duration: 120, day: '1/2/1993', start_time: '1800')
    UserShowing.create!(user: @user, showing: @showing, user_hosting: false)
    UserShowing.create!(user: @user2, showing: @showing, user_hosting: true)
    UserShowing.create!(user: @user3, showing: @showing, user_hosting: false)

  end
  it 'can get host name' do
    expect(@showing.host).to eq(@user2.email)
  end

  it 'can get invitees' do
    expect(@showing.invitees).to eq([@user, @user3])
  end
end
