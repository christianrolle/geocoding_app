require 'rails_helper'

RSpec.shared_context 'with Geocoding API request' do
  let(:geocoded_address) do
    {
      lat: '1.2345678',
      lon: '2.3456789',
      address: { road: params[:street],
                 house_number: '1',
                 postcode: params[:zip_code],
                 city: params[:city],
                 state: 'Test state',
                 country_code: 'de' }
    }
  end
  before do
    query = "#{params[:street]} #{params[:city]} #{params[:zip_code]}"
    stub_request(:get, 'https://nominatim.openstreetmap.org/search')
      .with(headers: { 'User-Agent' => 'fortytools' },
            query: { q: query, format: :json, addressdetails: 1,
                                                        'accept-language' => 'en' })
      .and_return(status: 200, body: geocoded_address.to_json)
  end
end

RSpec.describe 'User Registration', type: :request do
  describe 'POST /users' do
    let(:params) do
      {
        email: 'email@user.com',
        password: 'Passw0rd',
        password_confirmation: 'Passw0rd',
        street: 'Main street',
        city: 'Test city',
        zip_code: '12345'
      }
    end
    subject(:register_user) { post user_registration_path, params: { user: params } }

    context 'with valid parameters' do
      include_context 'with Geocoding API request'
      before { register_user }

      it 'redirects to the profile page' do
        expect(response).to redirect_to(root_path)
      end

      it 'creates user with registration parameters' do
        register_user
        expect(User.all).to match_array(have_attributes(
          email: params[:email],
          longitude: geocoded_address[:lon].to_f,
          latitude: geocoded_address[:lat].to_f,
          street: geocoded_address[:address][:road],
          house_number: geocoded_address[:address][:house_number],
          zip_code: geocoded_address[:address][:postcode],
          city: geocoded_address[:address][:city],
          state: geocoded_address[:address][:state],
          country_code: geocoded_address[:address][:country_code]
        ))
      end
    end

    context 'with invalid password' do
      include_context 'with Geocoding API request'
      before do
        params.update password: 'short', password_confirmation: 'short'
        register_user
      end

      it 'returns validation error status' do
        expect(response).to have_http_status(422)
      end

      it 'skips creating user' do
        expect(User.count).to be_zero
      end

      it 'renders too-short-password error' do
        expect(response.body).to include('Password is too short')
      end
    end

    context 'with missing street' do
      before { params.update street: '' }

      it 'renders missing-address error' do
        register_user
        expect(response.body).to include(ERB::Util.html_escape "Street can't be blank")
      end
    end

    context 'with unknown address' do
      before { params.update address: '???' }
      include_context 'with Geocoding API request'
      let(:geocoded_address) { {} }

      it 'renders unknown-address error' do
        register_user
        expect(response.body).to include('Address is unknown')
      end
    end

    context 'when geocoded address city is admin level 4 like Berlin' do
      before { geocoded_address[:address].delete(:state) }
      include_context 'with Geocoding API request'

      it 'perists the city name for state' do
        register_user
        expect(User.all).to match_array(
          have_attributes(state: geocoded_address[:address][:city])
        )
      end
    end

    context 'when geocoded address is a village' do
      before do
        geocoded_address[:address].delete :city
        geocoded_address[:address][:village] = 'Test village'
      end
      include_context 'with Geocoding API request'

      it 'perists the village name for city' do
        register_user
        expect(User.all).to match_array(
          have_attributes(city: geocoded_address[:address][:village])
        )
      end
    end
  end
end
