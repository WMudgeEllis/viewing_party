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
end
