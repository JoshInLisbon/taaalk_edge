class CreateTlks < ActiveRecord::Migration[6.0]
  def change
    create_table :tlks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
