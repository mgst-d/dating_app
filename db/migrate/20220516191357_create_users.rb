class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birth
      t.boolean :sex
      t.integer :work_id
      t.text :yourself
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
