# frozen_string_literal: true

class AdminAuthorization < ActiveAdmin::AuthorizationAdapter
    def authorized?(action, subject = nil)
        # Retrieve subject class name
        classname = subject.is_a?(Class) ? subject.name : subject.class.name
        user.set_active_at

        return true if user.is_admin?
        return false if classname == "User"
        return true if classname == "ActiveAdmin::Page" and subject.name == "Dashboard"

        if user.is_writer?
            if classname == "ActiveAdmin::Page"
                return user.is_special_invitee? if action.in? [:create, :read, :update, :destroy]
                return false
            end
            if action.in? [:create, :update, :destroy]
                return false if classname == "Consumable"
                return false if classname == "Equipment"
                return false if classname == "Idol"
            end
            return true if action.in? [:create, :read, :update, :destroy]
        elsif user.is_reader?
            if classname == "ActiveAdmin::Page"
                return user.is_special_invitee? if action == :read
                return false
            end
            return true if action == :read
        elsif user.is_guest?
            return false if classname == "Card"
            return false if classname == "Recipe"
            return false if classname == "LevelUpCard"
            return false if classname == "Consumable"
            return false if classname == "Equipment"
            return false if classname == "Idol"
            return false if classname == "ActiveAdmin::Page"
            return true if action == :read
        end
    end
end
