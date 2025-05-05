class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    signup_parameters = %i[street city zip_code]
    devise_parameter_sanitizer.permit(:sign_up, keys: signup_parameters)
    devise_parameter_sanitizer.permit(:account_update, keys: signup_parameters)
  end
end
