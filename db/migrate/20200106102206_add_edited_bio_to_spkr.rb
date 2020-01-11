class AddEditedBioToSpkr < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :edited_bio, :string
  end
end
