require 'rails_helper'

RSpec.feature 'UserSignUps', type: :feature do
  scenario 'User can sign up' do
    visit new_user_registration_path
    
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'Passw0rd'
    fill_in 'Password confirmation', with: 'Passw0rd'
    fill_in 'Address', with: 'Main street 1'
    click_button 'Sign up'
    
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end
end
