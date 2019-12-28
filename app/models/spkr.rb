class Spkr < ApplicationRecord
  belongs_to :tlk
  belongs_to :user
  has_many :msgs, dependent: :destroy
end
