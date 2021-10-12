class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  # has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  # has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :user_showings, dependent: :destroy
  has_many :showings, through: :user_showings

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
