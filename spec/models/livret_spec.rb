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
end
