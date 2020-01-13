class TlkFollow < ApplicationRecord
  belongs_to :user
  belongs_to :tlk

  # validates_uniqueness_of :user_id, scope: :tlk_id
end
