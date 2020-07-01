class AddToReplyToSpkrs < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :to_reply, :boolean, default: false
  end
end
