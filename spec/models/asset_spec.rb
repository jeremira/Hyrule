require 'rails_helper'

describe Asset  do

    before :each do
      @asset = build(:asset)
    end

    it "has a valid factory" do
      expect(@asset).to be_valid
    end

    it "is is NOT valid witout a map" do
      @asset = build(:asset, map: nil)
      expect(@asset).to_not be_valid
    end

    it "is has an Map file attached" do
      expect(@asset).to have_attached_file(:map)
    end

    it "belong to a Livret" do
      expect(@asset.livret).to be_kind_of Livret
    end

end
