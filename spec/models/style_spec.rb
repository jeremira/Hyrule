require 'rails_helper'

describe Style  do

    before :each do
      @style = FactoryGirl.create(:style)
    end

    it "has a valid factory" do
      expect(@style).to be_valid
    end

end
