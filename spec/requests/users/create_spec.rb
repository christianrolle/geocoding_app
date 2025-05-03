require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  describe 'POST /users' do
    let(:params) do
      {
        email: 'test@example.com',
        password: 'Passw0rd',
        password_confirmation: 'Passw0rd'
      }
    end
    subject(:register_user) { post user_registration_path, params: { user: params } }

    context 'with valid params' do
      before { register_user }

      it 'redirects to the profile page' do
        expect(response).to redirect_to(root_path)
      end

      it 'creates user with registration parameters' do
        register_user
        expect(User.all).to match_array(have_attributes(email: params[:email]))
      end
    end

    context 'with invalid attributes' do
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

      it 'renders validation error' do
        expect(response.body).to include('Password is too short')
      end
    end
  end
end
