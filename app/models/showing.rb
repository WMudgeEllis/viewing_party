class Showing < ApplicationRecord
  has_many :user_showings, dependent: :destroy
  has_many :users, through: :user_showings

  validates :movie_title, presence: true
  validates :duration, presence: true
  validates :day, presence: true
  validates :start_time, presence: true



  def host
    users.find_by(user_showings: {user_hosting: true}).email
  end

  def invitees
    users.where(user_showings: {user_hosting: false})
  end
end
