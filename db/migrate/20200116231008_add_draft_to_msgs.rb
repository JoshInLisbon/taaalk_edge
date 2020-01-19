class AddDraftToMsgs < ActiveRecord::Migration[6.0]
  def change
    add_column :msgs, :draft, :boolean, default: false
  end
end
