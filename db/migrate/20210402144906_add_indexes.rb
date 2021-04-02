class AddIndexes < ActiveRecord::Migration[6.1]
  def change
    add_index :cards, :name, unique: true
    add_index :items, [:name, :type], unique: true
  end
end
