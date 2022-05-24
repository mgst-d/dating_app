class AddWork < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :title

      t.timestamps
    end
  end
end
