class AddTypeAndLevelInItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :item_class, :string, null: true
    add_column :items, :level, :integer, default: 0
  end
end
