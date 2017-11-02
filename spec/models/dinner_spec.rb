require 'rails_helper'

describe Dinner  do

    before :each do
      @dinner = build(:dinner)
    end

    it "has a valid factory" do
      expect(@dinner).to be_valid
    end
end
