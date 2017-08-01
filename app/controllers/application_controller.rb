class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def only_admin
    unless current_user && current_user.admin
      flash[:alert] = "Cette section est réservé aux administrateurs."
      redirect_to root_url
    end
  end

end
