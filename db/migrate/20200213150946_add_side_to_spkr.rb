class AddSideToSpkr < ActiveRecord::Migration[6.0]
  def change
    add_column :spkrs, :side, :string
  end
end
