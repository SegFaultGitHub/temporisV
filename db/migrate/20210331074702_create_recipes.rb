class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes, id: :uuid do |t|
      t.uuid    :card1_id,     null: false
      t.uuid    :card2_id,     null: false
      t.uuid    :card3_id,     null: false
      t.uuid    :card4_id,     null: false
      t.uuid    :card5_id,     null: false
      t.uuid    :item_id,      null: false
      t.integer :quantity,  null: false, default: 1

      t.timestamps
    end
  end
end
