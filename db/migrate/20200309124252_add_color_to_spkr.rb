class AddColorToSpkr < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :color, :string
  end
end
