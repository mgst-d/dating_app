class AddHobby < ActiveRecord::Migration[7.0]
  def change
    create_table :hobbies do |t|
      t.string :title

      t.timestamps
    end
    add_reference :hobby_users, :hobby
  end
end
