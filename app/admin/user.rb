ActiveAdmin.register User do
  menu priority: 99

  permit_params :email, :password, :password_confirmation, :role_id, :special_invitee

  filter :role
  scope("Tout") { |scope| scope.where("true") }
  scope("Actifs") { |scope| scope.where("active_at > (NOW() - INTERVAL '5 MINUTES')") }

  index do
    column :email
    column :created_at
    column :role
    column :special_invitee
    column :active?
    column :active_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :role
      row :special_invitee
      row :active_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :role, collection: Role.order(:name), include_blank: false
      f.input :special_invitee
    end
    f.actions
  end
end
