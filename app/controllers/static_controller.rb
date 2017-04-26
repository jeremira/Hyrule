class StaticController < ApplicationController

  def welcome
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end

end
