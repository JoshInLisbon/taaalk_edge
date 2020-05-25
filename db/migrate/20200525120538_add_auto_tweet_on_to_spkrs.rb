class AddAutoTweetOnToSpkrs < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :auto_tweet_on, :boolean, default: true
  end
end
