class AddViewsToTlks < ActiveRecord::Migration[6.0]
  def change
    add_column :tlks, :views, :integer, default: 0
  end
end
