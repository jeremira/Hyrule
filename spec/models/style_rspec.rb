require 'rails_helper'

describe Style  do

    before :each do
      @style = build(:budget)
    end

    it "has a valid factory" do
      expect(@style).to be_valid
    end
end
