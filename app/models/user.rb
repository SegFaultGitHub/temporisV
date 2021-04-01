class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: (6..128), allow_blank: true

  validate :authorized_user
  def authorized_user
    errors.add(:email, "#{self.email} is not authorized") unless AuthorizedUser.find_by(login: self.email.downcase)
  end

  protected

  # From Devise module Validatable
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
