class AddCardInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :cards, :color,      :text,    null: false
    add_column :cards, :super_card, :boolean, null: false, default: false
    add_index :cards, :color
    add_index :cards, :super_card
  end
end
