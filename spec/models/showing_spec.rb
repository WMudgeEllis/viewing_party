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
  end

  it 'can get host name' do
    @user = User.create!(email: "sunlesskhan@kahn.com", password: "flipreset")
    @user2 = User.create!(email: "scar@sa.net", password: "face")
    @showing = Showing.create!(movie_title: 'star warz', duration: 120, day: '1/2/1993', start_time: '1800')
    UserShowing.create!(user: @user, showing: @showing, user_hosting: false)
    UserShowing.create!(user: @user2, showing: @showing, user_hosting: true)
    UserShowing.create!(user: @user, showing: @showing, user_hosting: false)

    expect(@showing.host).to eq(@user2.email)
  end
end
