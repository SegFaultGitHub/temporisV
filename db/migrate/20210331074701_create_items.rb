class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items, id: :uuid do |t|
      t.text :name, null: false

      t.timestamps
    end
  end
end
