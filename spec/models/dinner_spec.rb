require 'rails_helper'

describe Dinner  do

    before :each do
      @dinner = FactoryGirl.create(:dinner)
    end

    it "has a valid factory" do
      expect(@dinner).to be_valid
    end
    it "has a style" do
      @dinner.style = nil
      expect(@dinner).to_not be_valid
    end
end
