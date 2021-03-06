class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :set_locale

    def set_locale
      I18n.locale = :fr
    end
end
