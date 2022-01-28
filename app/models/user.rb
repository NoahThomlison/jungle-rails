class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  has_secure_password

  def authenticate_with_credentials(email, password)
    email = email.strip
    email = email.downcase
    user = User.find_by_email(email)

    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      return user
    else
      nil
    end
  end
end
