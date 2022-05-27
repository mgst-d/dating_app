class AddIndexToWork < ActiveRecord::Migration[7.0]
  def change
    add_index :works, :title, unique: true
  end
end
