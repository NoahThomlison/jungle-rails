class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, case_sensitive: false 
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
  has_secure_password
  before_save { email.downcase!}

  def authenticate_with_credentials(email, password)   
    email = email.strip
    email = email.downcase    
    puts email
    @user = User.find_by_email(email)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
