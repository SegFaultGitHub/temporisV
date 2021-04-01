class AddGuestRole < ActiveRecord::Migration[6.1]
  def change
    Role.create!(name: "Guest")
  end
end
