class AddDraftStringToMsgs < ActiveRecord::Migration[6.0]
  def change
    add_column :msgs, :draft_string, :string
  end
end
