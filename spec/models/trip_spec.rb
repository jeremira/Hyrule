require 'rails_helper'

describe Trip  do

    before :each do
      @trip = build(:trip)
    end

    it "has a valid factory" do
      expect(@trip).to be_valid
    end

    describe "Trip name" do
      it "is invalid without a name" do
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
      it "is invalid without a pickup place" do
        @trip.pickup_place = nil
        expect(@trip).to_not be_valid
      end
      it "accept a pickup place of 39 chars" do
        @trip.pickup_place = "a" * 39
        expect(@trip).to be_valid
      end
      it "accept a pickup place of 40 chars" do
        @trip.pickup_place = "a" * 40
        expect(@trip).to be_valid
      end
      it "dont accept a pickup place of 41 chars" do
        @trip.pickup_place = "a" * 41
        expect(@trip).to_not be_valid
      end
    end

    it "is invalid without an adult count" do
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

    describe "can_be_deleted?" do
      before :each do
        create(:gestion, trip: @trip)
      end
      it "return true for a new trip" do
        @trip.gestion.status = 'new'
        expect(@trip.can_be_deleted?).to be true
      end
      it "return true for a pending trip" do
        @trip.gestion.status = 'pending'
        expect(@trip.can_be_deleted?).to be true
      end
      it "return true for a approved trip" do
        @trip.gestion.status = 'approved'
        expect(@trip.can_be_deleted?).to be true
      end
      it "return false for a payed trip" do
        @trip.gestion.status = 'payed'
        expect(@trip.can_be_deleted?).to be false
      end
      it "return false for a final trip" do
        @trip.gestion.status = 'final'
        expect(@trip.can_be_deleted?).to be false
      end
      it "return false for a invalid trip" do
        @trip.gestion.status = nil
        expect(@trip.can_be_deleted?).to be false
      end
    end

    describe "can_be_edited?" do
      before :each do
        create(:gestion, trip: @trip)
      end
      it "return true for a new trip" do
        @trip.gestion.status = 'new'
        expect(@trip.can_be_edited?).to be true
      end
      it "return true for a pending trip" do
        @trip.gestion.status = 'pending'
        expect(@trip.can_be_edited?).to be false
      end
      it "return true for a approved trip" do
        @trip.gestion.status = 'approved'
        expect(@trip.can_be_edited?).to be false
      end
      it "return false for a payed trip" do
        @trip.gestion.status = 'payed'
        expect(@trip.can_be_edited?).to be false
      end
      it "return false for a final trip" do
        @trip.gestion.status = 'final'
        expect(@trip.can_be_edited?).to be false
      end
      it "return false for a invalid trip" do
        @trip.gestion.status = nil
        expect(@trip.can_be_edited?).to be false
      end
    end

end
