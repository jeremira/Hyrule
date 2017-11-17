require 'rails_helper'

describe Asset  do

    before :each do
      @asset = build(:asset)
    end

    it "has a valid factory" do
      expect(@asset).to be_valid
    end

end
