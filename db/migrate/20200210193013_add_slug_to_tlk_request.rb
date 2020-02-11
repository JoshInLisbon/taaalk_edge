class AddSlugToTlkRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :tlk_requests, :slug, :string
    add_index :tlk_requests, :slug, unique: true
  end
end
