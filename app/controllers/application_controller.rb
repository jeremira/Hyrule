class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def only_admin
    unless current_user.admin
      flash[:alert] = "Only admin here !"
      redirect_to root_url
    end
  end

end
