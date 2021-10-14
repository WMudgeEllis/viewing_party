require 'rails_helper'

RSpec.describe UserShowing do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:showing)}
  end
  describe 'validations' do
    it {should validate_exclusion_of(:user_hosting).in_array([nil])}
  end
end
