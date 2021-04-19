# frozen_string_literal: true

class AdminAuthorization < ActiveAdmin::AuthorizationAdapter
    def authorized?(action, subject = nil)
        user.set_active_at

        # Retrieve subject class name
        page =  if subject.is_a?(ActiveAdmin::Page) || subject.is_a?(Class)
                    subject.name
                else
                    subject.class.name
                end

        return true if user.is_admin?

        if user.is_writer?
            return check_authorization(action, page, writer_authorizations, user)
        elsif user.is_reader?
            return check_authorization(action, page, reader_authorizations, user)
        elsif user.is_guest?
            return check_authorization(action, page, guest_authorizations, user)
        end

        return false
    end

    private

    def check_authorization(action, page, authorizations, user)
        if user.is_special_invitee? and authorizations[:special].include? page
            return authorizations[:special][page].include? action
        elsif authorizations.include? page
            return authorizations[page].include? action
        end
    end

    def writer_authorizations
        {
            "Card" =>        [:create, :read, :update, :destroy],
            "Recipe" =>      [:create, :read, :update, :destroy],
            "Consumable" =>  [:read],
            "Equipment" =>   [:read],
            "Idol" =>        [:read],
            "LevelUpCard" => [:create, :read, :destroy],
            "dashboard" =>   [:read],
            special: {
                "search_recipes" =>  [:read],
                "unknown_recipes" => [:read],
                "random_recipes" =>  [:read]
            }
        }
    end

    def reader_authorizations
        {
            "Card" =>        [:read],
            "Recipe" =>      [:read],
            "Consumable" =>  [:read],
            "Equipment" =>   [:read],
            "Idol" =>        [:read],
            "LevelUpCard" => [:read],
            "dashboard" =>   [:read],
            special: {
                "search_recipes" =>  [:read],
                "unknown_recipes" => [:read],
                "random_recipes" =>  [:read]
            }
        }
    end

    def guest_authorizations
        {
            "dashboard" => [:read],
            special: { }
        }
    end
end
