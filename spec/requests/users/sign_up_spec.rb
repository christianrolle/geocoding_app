require 'rails_helper'

RSpec.describe 'User Sign up', type: :request do
  describe 'GET /users/sign_up' do
    before { get new_user_registration_path }

    it 'returns success status' do
      expect(response).to be_ok
    end

    it 'renders the registration page' do
      expect(response.body).to include('Sign up')
    end
  end
end
