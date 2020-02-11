class AddKeyToTlkRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :tlk_requests, :key, :integer
  end
end
