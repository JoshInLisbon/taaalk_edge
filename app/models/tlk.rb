class Tlk < ApplicationRecord
  belongs_to :user
  has_many :spkrs, dependent: :destroy
  has_many :msgs, dependent: :destroy

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, DateTime.now.to_date]
    ]
  end
end
