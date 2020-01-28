class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tlks, dependent: :destroy
  has_many :spkrs, dependent: :destroy
  has_many :msgs, dependent: :destroy
  has_many :draft_msgs, dependent: :destroy
  has_many :tlk_follows, dependent: :destroy

  # UserFollow
  has_many :received_follows, foreign_key: :followed_user_id, class_name: "UserFollow"
  has_many :followers, through: :received_follows, source: :follower
  has_many :given_follows, foreign_key: :follower_id, class_name: "UserFollow"
  has_many :followings, through: :given_follows, source: :followed_user

  has_one_attached :image

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :username,
      [:username, DateTime.now.to_date]
    ]
  end

  def is_follower_of_tlk?(tlk)
    arr = []
    tlk_follows.each do |tlk_following|
      arr << "true" if tlk_following.tlk_id == tlk.id
    end
    true if arr.any?
  end

  def is_follower_of_user?(user)
    arr = []
    followings.each do |user_followed|
      arr << user_followed if user_followed == user
    end
    true if arr.any?
  end
end
