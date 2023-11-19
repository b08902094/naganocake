class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:lastname, :firstname, :firstname_kana, :lastname_kana, :email, :postal_code, :address, :phone])
  end
end
