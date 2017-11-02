require 'rails_helper'

describe Trip  do

    before :each do
      @trip = build(:trip)
    end

    it "has a valid factory" do
      expect(@trip).to be_valid
    end

    describe "Trip name" do
      it "require a name" do
        @trip.name = nil
        expect(@trip).to_not be_valid
      end
      it "accept a name of 29 chars" do
        @trip.name = "a" * 29
        expect(@trip).to be_valid
      end
      it "accept a name of 30 chars" do
        @trip.name = "a" * 30
        expect(@trip).to be_valid
      end
      it "dont accept a name of 31 chars" do
        @trip.name = "a" * 31
        expect(@trip).to_not be_valid
      end
    end

    describe "Trip pickup place" do
      it "require a pickup place" do
        @trip.pickup_place = nil
        expect(@trip).to_not be_valid
      end
      it "accept a pickup place of 39 chars" do
        @trip.pickup_place = "a" * 39
        expect(@trip).to be_valid
      end
      it "accept a name of 40 chars" do
        @trip.pickup_place = "a" * 40
        expect(@trip).to be_valid
      end
      it "dont accept a name of 41 chars" do
        @trip.pickup_place = "a" * 41
        expect(@trip).to_not be_valid
      end
    end

    it "require adult count" do
      @trip.adults = nil
      expect(@trip).to_not be_valid
    end

    describe "Price update" do
      it "call setup_trip_price at saving" do
        expect(@trip).to receive(:setup_trip_price)
        @trip.save
      end
      it "update the trip price" do
        @trip.save
        @trip.price = 0
        expect{@trip.setup_trip_price}.to change{@trip.price}.from(0).to(15)
      end
    end

end
