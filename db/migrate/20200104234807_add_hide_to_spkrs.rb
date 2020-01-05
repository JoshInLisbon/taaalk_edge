class AddHideToSpkrs < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :hide, :boolean, default: false
  end
end
