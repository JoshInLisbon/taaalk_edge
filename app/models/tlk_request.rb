class TlkRequest < ApplicationRecord
  has_rich_text :tlk_with_you
  has_rich_text :first_msg

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, DateTime.now.to_date]
    ]
  end
end
