class DropAuthorizedUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :authorized_users, id: :uuid do |t|
      t.string :login

      t.timestamps
    end
  end
end
