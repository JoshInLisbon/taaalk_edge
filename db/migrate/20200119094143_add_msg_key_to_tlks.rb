class AddMsgKeyToTlks < ActiveRecord::Migration[6.0]
  def change
    add_column :tlks, :msg_key, :string
  end
end
