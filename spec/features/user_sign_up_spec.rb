require 'rails_helper'

RSpec.feature 'UserSignUps', type: :feature do
  let(:geocoded_address) do
    {
      lat: '1.2345678',
      lon: '2.3456789',
      address: { road: 'Main Street',
                 house_number: '1',
                 postcode: '12345',
                 city: 'Test city',
                 state: 'Test state',
                 country_code: 'de' }
    }
  end
  before do
    stub_request(:get, 'https://nominatim.openstreetmap.org/search')
      .with(headers: { 'User-Agent' => 'fortytools' },
            query: { q: 'Main street Test city 12345', format: :json, addressdetails: 1,
                                                       'accept-language' => 'en' })
      .and_return(status: 200, body: geocoded_address.to_json)
  end

  scenario 'User can sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'Passw0rd'
    fill_in 'Password confirmation', with: 'Passw0rd'
    fill_in 'Street', with: 'Main street'
    fill_in 'Postal code', with: '12345'
    fill_in 'Locality', with: 'Test city'
    click_button 'Sign up'
    
    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(page).to have_text(geocoded_address[:address][:road])
    expect(page).to have_text(geocoded_address[:address][:house_number])
    expect(page).to have_text(geocoded_address[:address][:postcode])
    expect(page).to have_text(geocoded_address[:address][:city])
    expect(page).to have_text(geocoded_address[:address][:state])
    expect(page).to have_text(geocoded_address[:address][:country_code])
    expect(page).to have_text(geocoded_address[:lon])
    expect(page).to have_text(geocoded_address[:lat])
  end
end
