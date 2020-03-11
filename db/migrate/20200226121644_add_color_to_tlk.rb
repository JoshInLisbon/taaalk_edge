class AddColorToTlk < ActiveRecord::Migration[6.0]
  def change
    add_column :tlks, :color, :string
  end
end
