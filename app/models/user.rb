class User < ApplicationRecord
  attr_accessor :address
  geocoded_by :address
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable
  validates :address, presence: true, on: :create
  validate :reasonable_address, on: :create, if: -> { address.present? }
  before_create :assign_address_attributes

  private

  def reasonable_address
    return true if geocoded_address.present?

    errors.add(:address, message: :unknown)
  end

  def assign_address_attributes
    self.attributes = geocoded_address.attributes
  end

  def geocoded_address
    @geocoded_address ||= GeocodedAddress.search(address)
  end
end
