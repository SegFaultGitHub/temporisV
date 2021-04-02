class ChangeColumnsNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :cards,  :recipe_count,  false
    change_column_null :items,  :item_type,     false
    change_column_null :items,  :level,         false
    change_column_null :items,  :recipe_count,  false
    change_column_null :users,  :role_id,       false
  end
end
