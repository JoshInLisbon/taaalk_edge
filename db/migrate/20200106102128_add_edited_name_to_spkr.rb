class AddEditedNameToSpkr < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :edited_name, :string
  end
end
