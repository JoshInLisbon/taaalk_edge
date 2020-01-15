class CreateUserFollowTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_follows, id: false do |t|
      t.integer :user_id
      t.integer :user_followed_id
    end

    add_index(:user_follows, [:user_id, :user_followed_id], :unique => true)
    add_index(:user_follows, [:user_followed_id, :user_id], :unique => true)
  end
end
