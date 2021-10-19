class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :user_showings, dependent: :destroy
  has_many :showings, through: :user_showings

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password

  def friend?(friend_email)
    friends.pluck(:email).include?(friend_email)
  end

  def self.get_by_email(emails)
    where(email: emails)
  end
end
