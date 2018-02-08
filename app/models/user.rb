class User < ApplicationRecord
  has_many :favorites
  has_many :comments

  has_secure_password
end
