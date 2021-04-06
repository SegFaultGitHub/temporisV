class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
    :rememberable
    
    validates_presence_of   :email
    validates_uniqueness_of :email
    validate                :email_without_at
    validates_presence_of     :password, if: :password_required?
    validates_confirmation_of :password, if: :password_required?
    validates_length_of       :password, within: (6..128), allow_blank: true
    
    belongs_to :role
    after_initialize :set_role
    
    def email_without_at
        errors.add(:email, "can not contain '@'") if email.include? "@"
    end
    def set_role
        self.role ||= Role.find_by(name: "Guest")
    end
    
    def is_admin?
        role == Role.find_by(name: "Admin")
    end
    def is_writer?
        role == Role.find_by(name: "Writer")
    end
    def is_reader?
        role == Role.find_by(name: "Reader")
    end
    def is_guest?
        role == Role.find_by(name: "Guest")
    end
    def is_special_invitee?
        special_invitee
    end
    
    def set_active_at
        update_columns active_at: DateTime.now
    end
    def active?
        !active_at.nil? && active_at > 5.minutes.ago
    end
    
    protected
    
    # From Devise module Validatable
    def password_required?
        !persisted? || !password.nil? || !password_confirmation.nil?
    end
end
