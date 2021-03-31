class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards, id: :uuid do |t|
      t.text    :name,  null: false
      t.integer :level, null: false

      t.timestamps
    end
  end
end
