class AddTypeColumnInItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :item_class, :item_type
    add_column :items, :type, :text, null: false
  end
end
