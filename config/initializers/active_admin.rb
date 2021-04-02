ActiveAdmin.setup do |config|
  config.site_title = "Temporis V"
  config.authentication_method = :authenticate_user!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
  config.comments = false
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.authorization_adapter = "AdminAuthorization"

  
  config.namespace :admin do |admin|
    # priority: 1 -> "Dashboard"
    admin.build_menu do |menu|
      menu.add label: "Items", priority: 2
      # priority: 3 -> "Recipes"
      menu.add label: "Tools", priority: 4
    end
  end
end
