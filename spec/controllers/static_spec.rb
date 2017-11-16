require 'rails_helper'

describe StaticController  do
#===============================================================================
#  GET /trips/
#===============================================================================
  describe "GET index" do
    it "respond successfully" do
      expect(get :index).to be_success
    end
  end
end
