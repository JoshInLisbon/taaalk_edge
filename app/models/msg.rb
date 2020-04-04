class Msg < ApplicationRecord
  belongs_to :user
  belongs_to :tlk
  belongs_to :spkr

  has_rich_text :content
  has_rich_text :safe_content

  validates :safe_content, presence: { if: -> { draft_string.blank? }}
  validates :draft_string, presence: { if: -> { safe_content.blank? }}
end
