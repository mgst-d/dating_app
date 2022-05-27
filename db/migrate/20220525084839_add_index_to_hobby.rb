class AddIndexToHobby < ActiveRecord::Migration[7.0]
  def change
    add_index :hobbies, :title, unique: true
  end
end
