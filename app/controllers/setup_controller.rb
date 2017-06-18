class SetupController < ApplicationController
  before_action :only_admin

  def index
    @pending_trips = Trip.all.where(status: 1)
  end

end
