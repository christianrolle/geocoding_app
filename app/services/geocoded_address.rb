class GeocodedAddress
  def initialize(address = {})
    @address = address
  end

  def self.search(address_search)
    # a different way of choosing requires user input
    new Geocoder.search(address_search).first
  end

  def attributes
    {
      latitude: address.latitude,
      longitude: address.longitude,
      street: address.street,
      house_number: address.house_number,
      city: address.city,
      state: state,
      zip_code: address.postal_code,
      country_code: address.country_code
    }
  end

  delegate :present?, to: :data

  private

  # there might be additional special combinations in regards to an address state
  def state
    address.state || address.city
  end

  attr_reader :address
  delegate :data, to: :address
end
