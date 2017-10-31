require 'rails_helper'

describe Day  do

    before :each do
      @day = build(:day)
    end

    it "has a valid factory" do
      expect(@day).to be_valid
    end
end
