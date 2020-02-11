class CreateDraftMsgs < ActiveRecord::Migration[6.0]
  def change
    create_table :draft_msgs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tlk, null: false, foreign_key: true
      t.references :spkr, null: false, foreign_key: true

      t.timestamps
    end
  end
end
