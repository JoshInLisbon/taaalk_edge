class RemoveDescriptionFromTlk < ActiveRecord::Migration[6.0]
  def change
    remove_column :tlks, :description, :string
  end
end
