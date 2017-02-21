class User < ActiveRecord::Base
  ## settting up relationship to 1 to many articles
  has_many :articles
  before_save { self.email = email.downcase }
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            length: { maximum: 105},
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  ## use of bcrypt gem to enable 1 way password hashing 
  has_secure_password
  
end  