ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  before_filter :skip_sidebar!, only: :index

  index do
    column :email
    column :created_at
    column :role
    actions
  end

  show do
    attributes_table do
      row :email
      row :role
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :role, collection: Role.order(:name), include_blank: false
    end
    f.actions
  end
end
