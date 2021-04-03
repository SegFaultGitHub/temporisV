class AddLevelUpCardsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :level_up_cards, id: :uuid do |t|
      t.uuid    :card_id, null: false
      t.integer :level,   null: false

      t.timestamps
    end
    add_index :level_up_cards, :level,    unique: true
    add_index :level_up_cards, :card_id,  unique: true
  end
end
