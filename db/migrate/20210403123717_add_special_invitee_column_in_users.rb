class AddSpecialInviteeColumnInUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :special_invitee, :boolean, null: false, default: false
  end
end
