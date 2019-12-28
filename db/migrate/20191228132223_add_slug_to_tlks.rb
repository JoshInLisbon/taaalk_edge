class AddSlugToTlks < ActiveRecord::Migration[6.0]
  def change
    add_column :tlks, :slug, :string
    add_index :tlks, :slug, unique: true
  end
end
