require 'rails_helper'

describe Gestion  do

    before :each do
      @gestion = build(:gestion)
    end

    it "has a valid factory" do
      expect(@gestion).to be_valid
    end
end
