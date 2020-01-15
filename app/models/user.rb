class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tlks, dependent: :destroy
  has_many :spkrs, dependent: :destroy
  has_many :msgs, dependent: :destroy
  has_many :tlk_follows, dependent: :destroy

  has_and_belongs_to_many :user_follows,
        class_name: "User",
        join_table:  :user_follows,
        foreign_key: :user_id,
        association_foreign_key: :user_followed_id

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

  #   if tlk_follows.present?
  #     tlk_follows.each do |tlk_following|
  #       unless tlk_following == tlk

  #       end
  #     end
  #   else
  #     return false
  #   end
  # end
end
