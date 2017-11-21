require 'rails_helper'

describe Day  do

    before :each do
      @day = build(:day)
    end

    it "has a valid factory" do
      expect(@day).to be_valid
    end
    it "update price after saving" do
      expect(@day).to receive(:update_day_price)
      @day.save
    end

    describe "check if the date is valid" do
      it "has a date set" do
        @day.date = nil
        expect(@day).to_not be_valid
      end
      it "check if date is >14days" do
        expect(@day).to receive(:is_in_more_than_14_days?)
        @day.valid?
      end
    end

    describe "#update_day_price" do
      it "set the new price of the day" do
        @day.save
        @day.price = 0
        expect{@day.update_day_price}.to change{@day.price}.from(0).to(20)
      end
      it "call trip#setup_trip_price" do
        expect(@day.trip).to receive(:setup_trip_price)
        @day.save
      end
    end

    describe "is_in_more_than_14_days?" do
      it "is valid for a trip in 375 days" do
        @day.date = Date.today + 375.days
        expect(@day.is_in_more_than_14_days?).to be_truthy
      end
      it "is valid for a trip in 15 days" do
        @day.date = Date.today + 15.days
        expect(@day.is_in_more_than_14_days?).to be_truthy
      end
      it "is valid for a trip in 14 days" do
        @day.date = Date.today + 14.days
        expect(@day.is_in_more_than_14_days?).to be_truthy
      end
      it "is NOT valid for a trip in 13 days" do
        @day.date = Date.today + 13.days
        expect(@day.is_in_more_than_14_days?).to be_falsy
      end
      it "is NOT valid for a trip today" do
        @day.date = Date.today
        expect(@day.is_in_more_than_14_days?).to be_falsy
      end
      it "is NOT valid for a trip in the past" do
        @day.date = Date.yesterday
        expect(@day.is_in_more_than_14_days?).to be_falsy
      end
    end

end
