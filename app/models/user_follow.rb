class UserFollow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: "User"
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: "User"

  validates_uniqueness_of :follower_id, scope: :followed_user_id
end
