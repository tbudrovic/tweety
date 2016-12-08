class User < ApplicationRecord
  has_secure_password

  has_many :tweets

  validates :name, presence: true
  validates :password, presence: true
end
