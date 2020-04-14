class Tlk < ApplicationRecord
  belongs_to :user
  has_many :spkrs, dependent: :destroy
  has_many :msgs, dependent: :destroy
  has_many :tlk_follows, dependent: :destroy
  has_many :draft_msgs, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true

  def any_published_msgs?
    msgs.find_by(published: true).present?
  end

  def non_hidden_spkrs
    spkrs.where(hide: false).sort_by(&:created_at)
  end

  def non_tlk_user_spkrs
    spkrs.where.not(user: self.user).sort_by(&:created_at)
  end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, DateTime.now.to_date]
    ]
  end
end
