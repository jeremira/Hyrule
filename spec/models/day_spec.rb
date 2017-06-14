require 'rails_helper'

describe Day  do

    before :each do
      @day  =   FactoryGirl.create(:day)
      @lunch =  FactoryGirl.create(:lunch,  day: @day)
      @dinner = FactoryGirl.create(:dinner, day: @day)
    end

    it "has a valid factory" do
      expect(@day).to be_valid
    end

    it "has a theme" do
      @day.theme = nil
      expect(@day).to_not be_valid
    end

    describe "when deleting a Day" do
      it "destroy his lunch " do
        expect { @day.destroy }.to change { Lunch.count }.by(-1)
      end
      it "destroy his dinner" do
        expect { @day.destroy }.to change { Dinner.count }.by(-1)
      end
    end
end
