class AuthorizedUser < ActiveRecord::Base
  before_save :login_to_lower_case
  def login_to_lower_case
    self.login.downcase!
  end
end
