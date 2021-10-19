require 'rails_helper'

RSpec.describe MoviesFacade do
  before(:each) do
    @user = User.create!(email: "Sammy", password: "Sosa")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe 'class methods' do
    it 'returns the correct number of movies', :vcr do
      expect(MoviesFacade.top_40_movies.count).to eq(40)
    end
  end
end
