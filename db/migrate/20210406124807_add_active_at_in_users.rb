class AddActiveAtInUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :active_at, :datetime, null: true
  end
end
