ActiveAdmin.setup do |config|
  config.site_title = "Temporis V"
  config.logout_link_path = :destroy_admin_user_session_path
  config.comments = false
  config.batch_actions = true
end
