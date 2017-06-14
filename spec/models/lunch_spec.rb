require 'rails_helper'

describe Lunch  do

    before :each do
      @lunch = FactoryGirl.create(:lunch)
    end

    it "has a valid factory" do
      expect(@lunch).to be_valid
    end
    it "is has a style" do
      @lunch.style = nil
      expect(@lunch).to_not be_valid
    end
end
