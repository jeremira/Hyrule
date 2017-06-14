require 'rails_helper'

describe Rythme  do

    before :each do
      @rythme = FactoryGirl.create(:rythme)
    end

    it "has a valid factory" do
      expect(@rythme).to be_valid
    end
    it "has a general value" do
      @rythme.value = nil
      expect(@rythme).to_not be_valid
    end
    it "has a walking value" do
      @rythme.walking = nil
      expect(@rythme).to_not be_valid
    end
    it "has a transport value" do
      @rythme.transport = nil
      expect(@rythme).to_not be_valid
    end

end
