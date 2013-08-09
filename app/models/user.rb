class User < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 50 } 
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
