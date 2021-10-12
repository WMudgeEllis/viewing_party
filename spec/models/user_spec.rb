require 'rails_helper'

RSpec.describe User do

  describe 'relationships' do
    it {should have_many(:user_showings)}
    it {should have_many(:showings).through(:user_showings)}
  end
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password_digest)}
  end
end
