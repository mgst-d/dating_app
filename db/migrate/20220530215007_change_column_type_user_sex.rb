class ChangeColumnTypeUserSex < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :sex, :string
  end

  def down
    change_column :users, :sex, :boolean, using: 'sex::boolean'
  end
end
