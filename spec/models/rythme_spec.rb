require 'rails_helper'

describe Rythme  do

    before :each do
      @rythme = build(:rythme)
    end

    it "has a valid factory" do
      expect(@rythme).to be_valid
    end
end
