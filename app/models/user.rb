class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_secure_password
  
  validates :name, presence: true
  validates :name, length: { maximum: 50 } 
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
