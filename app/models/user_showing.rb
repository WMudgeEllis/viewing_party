class UserShowing < ApplicationRecord
  belongs_to :user
  belongs_to :showing

  validates :user_hosting, exclusion: [nil]
end
