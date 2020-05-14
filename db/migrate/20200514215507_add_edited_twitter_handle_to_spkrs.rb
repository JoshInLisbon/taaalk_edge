class AddEditedTwitterHandleToSpkrs < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :edited_twitter_handle, :string
  end
end
