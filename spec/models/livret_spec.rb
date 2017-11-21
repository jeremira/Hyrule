require 'rails_helper'

describe Livret  do

    before :each do
      @livret = build(:livret)
    end

    it "has a valid factory" do
      expect(@livret).to be_valid
    end

    it "require a html book" do
      @livret = build(:livret, htmlbook: nil)
      expect(@livret).to_not be_valid
    end

    it "is has an Html file attached" do
      expect(@livret).to have_attached_file(:htmlbook)
    end

    it "can have maps asset child" do
      @livret = create(:livret, :with_maps)
      expect(@livret).to be_valid
      expect(@livret.assets.length).to eq 2
    end
end
