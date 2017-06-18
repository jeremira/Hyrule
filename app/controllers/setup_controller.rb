class SetupController < ApplicationController
  before_action :only_admin

  def index
    @pending_trips = Trip.all
  end

end
