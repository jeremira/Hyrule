class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #add email_confirmation strong params to devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  def only_admin
    unless current_user && current_user.admin
      flash[:alert] = "Cette section est réservé aux administrateurs."
      redirect_to root_url
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:email_confirmation])
    end

end
