require 'rails_helper'

describe Lunch  do

    before :each do
      @lunch = build(:lunch)
    end

    it "has a valid factory" do
      expect(@lunch).to be_valid
    end
end
