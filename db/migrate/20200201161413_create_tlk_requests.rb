class CreateTlkRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :tlk_requests do |t|
      t.string :title
      t.integer :requesting_user_id
      t.integer :requested_user_id

      t.timestamps
    end
  end
end
