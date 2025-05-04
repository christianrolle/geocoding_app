class User < ApplicationRecord
  attr_accessor :address
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable
  validates :address, presence: true, on: :create
end
