require 'rails_helper'

describe Budget  do

    before :each do
      @budget = FactoryGirl.create(:budget)
    end

    it "has a valid factory" do
      expect(@budget).to be_valid
    end

    it "has a value" do
      @budget.value = nil
      expect(@budget).to_not be_valid
    end

end
