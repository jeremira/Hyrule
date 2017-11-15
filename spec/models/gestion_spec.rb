require 'rails_helper'

describe Gestion  do

    before :each do
      @gestion = build(:gestion)
    end

    it "has a valid factory" do
      expect(@gestion).to be_valid
    end

    it "has a status" do
      @gestion.status = nil
      expect(@gestion).to_not be_valid
    end

    describe ".is_bookable?" do
      it "has a .is_bookable method" do
        expect(@gestion).to respond_to(:is_bookable?)
      end
    context 'when status is new' do
      it "can be book for a 1 day trip" do
        @gestion.save
        @day = create(:day, trip: @gestion.trip)
        @gestion.reload
        expect(@gestion.is_bookable?).to be true
      end
      it "can be book for a 2 days trip" do
        @gestion.save
        @day = create(:day, trip: @gestion.trip)
        @day2 = create(:day, trip: @gestion.trip)
        @gestion.reload
        expect(@gestion.is_bookable?).to be true
      end
      it "cant be book for a no day trip" do
        @gestion.save
        expect(@gestion.is_bookable?).to be false
      end
    end
    context "when status is not New" do
      it "cant be book for a 0 day trip" do
        @gestion = create(:gestion, status: 'pending')
        expect(@gestion.is_bookable?).to be false
      end
      it "cant be book for a 1 day trip" do
        @gestion = create(:gestion, status: 'pending')
        @day = create(:day, trip: @gestion.trip)
        @gestion.reload
        expect(@gestion.is_bookable?).to be false
      end
      it "cant be book for a 2 day trip" do
        @gestion = create(:gestion, status: 'pending')
        @day = create(:day, trip: @gestion.trip)
        @day2 = create(:day, trip: @gestion.trip)
        @gestion.reload
        expect(@gestion.is_bookable?).to be false
      end
    end

    describe".book_trip" do
      it "has a .book_trip method" do
        expect(@gestion).to respond_to(:book_trip)
      end
      it "change status to Approved" do
        expect{@gestion.book_trip}.to change{@gestion.status}.from('new').to('approved')
      end
    end

    describe ".update_status" do
      it "has a .update_status method" do
        expect(@gestion).to respond_to(:update_status)
      end
      it "require an argument" do
         expect { @gestion.update_status }.to raise_error(ArgumentError)
      end
      context "when status is valid" do
        it "update status to New" do
          @gestion = create(:gestion, status: 'payed')
          @gestion.update_status('new')
          expect(@gestion.status).to eq 'new'
        end
        it "update status to Approved" do
          @gestion = create(:gestion, status: 'new')
          @gestion.update_status('approved')
          expect(@gestion.status).to eq 'approved'
        end
        it "update status to Payed" do
          @gestion = create(:gestion, status: 'new')
          @gestion.update_status('payed')
          expect(@gestion.status).to eq 'payed'
        end
        it "update status to Final" do
          @gestion = create(:gestion, status: 'new')
          @gestion.update_status('final')
          expect(@gestion.status).to eq 'final'
        end
        it "update status to Done" do
          @gestion = create(:gestion, status: 'new')
          @gestion.update_status('done')
          expect(@gestion.status).to eq 'done'
        end
      end
      context "when status is NOT valid" do
        it "doesnt update status" do
          expect{ @gestion.update_status(nil) }.to_not change{@gestion.status}
          expect{ @gestion.update_status(25) }.to_not change{@gestion.status}
          expect{ @gestion.update_status('krakoukas') }.to_not change{@gestion.status}
        end
      end
    end
  end
end
