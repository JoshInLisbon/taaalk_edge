class AddPublishedToMsgs < ActiveRecord::Migration[6.0]
  def change
    add_column :msgs, :published, :boolean, default: false
  end
end
