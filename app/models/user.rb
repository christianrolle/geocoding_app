class User < ApplicationRecord
  geocoded_by :address
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable
  validates :street, :zip_code, :city, presence: true, on: :create
  validate :reasonable_address, on: :create, if: -> { address_search_valid? }
  before_create :assign_address_attributes

  def address
    @address ||= "#{street} #{city} #{zip_code}"
  end

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

  def address_search_valid?
    street.present? && zip_code.present? && city.present?
  end
end
