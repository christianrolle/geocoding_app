class ProfileController < ActionController::Base
  def index
    @user = current_user
  end
end
