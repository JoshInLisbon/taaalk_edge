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

  def all_spkrs
    spkrs.sort_by(&:created_at)
  end

  def non_hidden_spkrs
    spkrs.where(hide: false).sort_by(&:created_at)
  end

  def non_tlk_user_spkrs
    spkrs.where.not(user: self.user).sort_by(&:created_at)
  end

  # def tweet
  #   routes = Rails.application.routes.url_helpers
  #   tlk_url = routes.show_tlk_url(self)
  #   tweet = "I wrote a new message in my Taaalk \"#{title}\""
  #   spkrs_tweet_section = ""
  #   spkrs_tweet_section << " with " if non_tlk_user_spkrs.length >= 1
  #   non_tlk_user_spkrs.each_with_index do |spkr, i|
  #     spkr_name_and_twitter = spkr.twitter_handle.present? ? "#{spkr.name} (@#{spkr.twitter_handle})" : spkr.name
  #     if non_tlk_user_spkrs.length == 1
  #       spkrs_tweet_section << "#{spkr_name_and_twitter}"
  #     elsif i + 2 == non_tlk_user_spkrs.length
  #       spkrs_tweet_section << "#{spkr_name_and_twitter} "
  #     elsif i + 1 == non_tlk_user_spkrs.length
  #       spkrs_tweet_section << "& #{spkr_name_and_twitter}"
  #     else
  #       spkrs_tweet_section << "#{spkr_name_and_twitter}, "
  #     end
  #   end
  #   if (tweet + spkrs_tweet_section).length <= 116
  #     tweet << spkrs_tweet_section + " #{tlk_url}"
  #   else
  #     tweet << " #{tlk_url}"
  #   end
  # end

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :title,
      [:title, DateTime.now.to_date]
    ]
  end
end
