class GestionsController < ApplicationController

  def update
    case params[:status]
    when 'new'

    when 'pending'

    when 'approved'

    when 'payed'

    when 'confirmed'

    when 'done'

    else
      flash[:alert] = "Got an invalid status : #{params[:status]}"
    end
    redirect_back(fallback_location: root_url)
  end

end
