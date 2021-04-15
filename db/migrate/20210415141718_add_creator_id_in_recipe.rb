class AddCreatorIdInRecipe < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :creator_id, :integer, null: true
    add_index :recipes, :creator_id
  end
end
