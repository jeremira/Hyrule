require 'rails_helper'

describe Trip  do

    before :each do
      @trip = FactoryGirl.create(:trip)
    end

    it "has a valid factory" do
      expect(@trip).to be_valid
    end

    it "has a name" do
      @trip.name = nil
      expect(@trip).to_not be_valid
    end

end
