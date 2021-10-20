require 'rails_helper'

RSpec.describe User do

  describe 'relationships' do
    it {should have_many(:user_showings)}
    it {should have_many(:showings).through(:user_showings)}
    it {should have_many(:friendships)}
    it {should have_many(:friends).through(:friendships)}
  end

  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password_digest)}
  end

  it 'can determine if someone is a friend' do
    user = User.create!(email: '123@123.com', password: '123')
    user2 = User.create!(email: 'abc@123.com', password: '123')
    user3 = User.create!(email: 'zyx@123.com', password: '123')
    user.friendships.create!(friend_id: user2.id)

    expect(user.friend?(user2.email)).to eq(true)
    expect(user.friend?(user3.email)).to eq(false)
    expect(user2.friend?(user.email)).to eq(false)
  end

  it 'can find user by array of email' do
    user = User.create!(email: '123@123.com', password: '123')
    user2 = User.create!(email: 'abc@123.com', password: '123')
    user3 = User.create!(email: 'zyx@123.com', password: '123')
    emails = [user.email, user2.email, user3.email]

    expect(User.get_by_email(emails)).to eq([user, user2, user3])
  end
end
