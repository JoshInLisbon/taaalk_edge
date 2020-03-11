class AddEditedColorToSpkr < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :edited_color, :string
  end
end
