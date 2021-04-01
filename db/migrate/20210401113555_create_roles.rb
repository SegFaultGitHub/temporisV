class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name, null: false
    end

    Role.create!(name: "Reader")
    Role.create!(name: "Admin")
    Role.create!(name: "Writer")
  end
end
