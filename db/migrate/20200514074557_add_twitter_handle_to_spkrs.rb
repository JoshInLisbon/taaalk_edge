class AddTwitterHandleToSpkrs < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :twitter_handle, :string
  end
end
