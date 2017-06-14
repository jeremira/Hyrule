require 'rails_helper'

describe Trip  do

    before :each do
      @trip =   FactoryGirl.create(:trip)
      @budget = FactoryGirl.create(:budget, trip: @trip)
      @style =  FactoryGirl.create(:style,  trip: @trip)
      @rythme = FactoryGirl.create(:rythme, trip: @trip)
      @day =    FactoryGirl.create(:day,    trip: @trip)
    end

    it "has a valid factory" do
      expect(@trip).to be_valid
    end

    it "has a name" do
      @trip.name = nil
      expect(@trip).to_not be_valid
    end

    it "has a status code" do
      @trip.status = nil
      expect(@trip).to_not be_valid
    end

    describe "when deleting a Trip" do
      it "destroy his budget " do
        expect { @trip.destroy }.to change { Budget.count }.by(-1)
      end
      it "destroy his rythme child" do
        expect { @trip.destroy }.to change { Rythme.count }.by(-1)
      end
      it "destroy his style  child" do
        expect { @trip.destroy }.to change { Style.count }.by(-1)
      end
      it "destroy his day child" do
        expect { @trip.destroy }.to change { Day.count }.by(-1)
      end
    end
end
