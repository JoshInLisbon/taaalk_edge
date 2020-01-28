class Spkr < ApplicationRecord
  belongs_to :tlk
  belongs_to :user
  has_many :msgs, dependent: :destroy
  has_one :draft_msg, dependent: :destroy

  has_one_attached :image

  has_rich_text :biog
  has_rich_text :edited_biog
end
