class CreateNewSpkrs < ActiveRecord::Migration[6.0]
  def change
    create_table :new_spkrs do |t|
      t.string :name
      t.string :bio
      t.string :email

      t.timestamps
    end
  end
end
