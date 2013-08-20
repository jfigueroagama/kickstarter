class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_secure_password
  
  has_many :projects, dependent: :destroy
  
  validates :name, presence: true
  validates :name, length: { maximum: 50 } 
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
  
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
