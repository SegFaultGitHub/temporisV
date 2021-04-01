class AddRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    guest_id = Role.find_by(name: "Reader").id
    add_column :users, :role_id, :uuid, default: guest_id
  end
end
