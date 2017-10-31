require 'rails_helper'

describe Trip  do

    before :each do
      @trip = build(:trip)
    end

    it "has a valid factory" do
      expect(@trip).to be_valid
    end
end
