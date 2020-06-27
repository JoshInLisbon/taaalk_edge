class Spkr < ApplicationRecord
  belongs_to :tlk
  belongs_to :user
  has_many :msgs, dependent: :destroy
  has_one :draft_msg, dependent: :destroy

  has_one_attached :image
  has_one_attached :edited_image

  has_rich_text :biog
  has_rich_text :edited_biog
  has_rich_text :notes

  validates :name, presence: true

  def unpublished_message
    msgs.find_by(published: false)
  end
end
