class AddIndexOnRecipeCards < ActiveRecord::Migration[6.1]
  def change
    add_index :recipes, :card1_id
    add_index :recipes, :card2_id
    add_index :recipes, :card3_id
    add_index :recipes, :card4_id
    add_index :recipes, :card5_id
    add_index :recipes, [:card1_id, :card2_id, :card3_id, :card4_id, :card5_id], unique: true, name: "index_recipes_on_cards"
  end
end
