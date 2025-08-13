class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  has_many :tasks, dependent: :destroy
end