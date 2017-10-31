require 'rails_helper'

describe Budget  do

    before :each do
      @budget = build(:budget)
    end

    it "has a valid factory" do
      expect(@budget).to be_valid
    end
end
