class RemoveDefaultRoleOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role_id, nil
  end
end
