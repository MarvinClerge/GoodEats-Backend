class User < ApplicationRecord
  has_many :favorites
  has_many :comments

  validates :username, presence: true, uniqueness: true;

  has_secure_password
end
