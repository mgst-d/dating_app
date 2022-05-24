class AddReferenceUserIdtoHobbyUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :hobby_users, :user
  end
end
