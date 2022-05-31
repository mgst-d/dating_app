class ChangeColumnTypeUserSex < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :sex, :integer, default: 0, using: 'sex::boolean'
  end

  def down
    remove_column_default :users, :sex, :integer
    change_column :users, :sex, :boolean, using: 'sex::boolean'
  end
end
