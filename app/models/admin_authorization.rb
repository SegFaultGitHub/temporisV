# frozen_string_literal: true

class AdminAuthorization < ActiveAdmin::AuthorizationAdapter
    def authorized?(action, subject = nil)
        # Retrieve subject class name
        classname = subject.is_a?(Class) ? subject.name : subject.class.name

        return true if classname == "Dashboard"

        return true if user.is_admin?
        return false if classname == "User"

        if user.is_writer?
            return true if action.in? [:create, :read, :update, :destroy]
            return true if classname == "ActiveAdmin::Page"
        elsif user.is_reader?
            return true if action == :read
            return true if classname == "ActiveAdmin::Page"
        end
    end
end
