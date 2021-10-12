class Showing < ApplicationRecord
  has_many :user_showings, dependent: :destroy
  has_many :users, through: :user_showings

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :day, presence: true
  validates :start_time, presence: true
end
