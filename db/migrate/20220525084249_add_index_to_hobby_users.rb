class AddIndexToHobbyUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :hobby_users, [:hobby_id, :user_id], unique: true
  end
end
