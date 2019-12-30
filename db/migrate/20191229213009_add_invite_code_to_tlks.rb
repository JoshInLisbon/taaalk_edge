class AddInviteCodeToTlks < ActiveRecord::Migration[6.0]
  def change
    add_column :tlks, :invite_code, :integer
  end
end
