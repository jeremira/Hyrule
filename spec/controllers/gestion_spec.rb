require 'rails_helper'

describe GestionsController  do
  before :each do
    @user = create(:user)
    @trip = create(:trip, user: @user)
    @gestion = create(:gestion, trip: @trip)
    @day = create(:day, trip: @trip)
  end

#===============================================================================
#    PUT /trips/id:
#===============================================================================
  describe "PUT update" do
    context "when owner is logged in" do
      before :each do
        request.env["HTTP_REFERER"] = "previous_location"
        sign_in @user
      end
      it "assign @trip" do
        put :update, params: {trip_id: @trip, id: @gestion }
        expect(assigns :trip).to eq @trip
      end
      it "assign @gestion" do
        put :update, params: {trip_id: @trip, id: @gestion }
        expect(assigns :gestion).to eq @gestion
      end
      it "update status to Approved" do
        put :update, params: {trip_id: @trip, id: @gestion }
        expect(@gestion.reload.status).to eq 'approved'
      end
      it 'send booking email' do
        message_delivery = double(ActionMailer::MessageDelivery)
        expect(MainMailer).to receive(:ready_email).with(@user, @trip).and_return(message_delivery)
        expect(message_delivery).to receive(:deliver)
        put :update, params: {trip_id: @trip, id: @gestion }
      end
      it "redirect to previous page" do
        put :update, params: {trip_id: @trip, id: @gestion }
        expect(response).to redirect_to "previous_location"
      end
    end
    context "when another user is logged in" do
      before :each do
        request.env["HTTP_REFERER"] = "previous_location"
        @other_user = create(:user)
        sign_in @other_user
      end
      it "deny access and raise exeption" do
        expect{ put :update, params: {trip_id: @trip, id: @gestion } }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context "when Admin is logged in" do
      before :each do
        request.env["HTTP_REFERER"] = "previous_location"
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "update status for every valid request" do
        valid_status = ['new', 'approved', 'payed', 'final', 'done']
        valid_status.each do |status|
          put :update, params: {trip_id: @trip, id: @gestion, status: status }
          expect(@gestion.reload.status).to eq status
        end
      end
      it "do NOT update status for an invalid request" do
        put :update, params: {trip_id: @trip, id: @gestion, status: 'krakoukass!' }
        expect(@gestion.reload.status).to eq 'new'
      end
      it "send email for a approved state trip" do
        message_delivery = double(ActionMailer::MessageDelivery)
        expect(MainMailer).to receive(:ready_email).with(@user, @trip).and_return(message_delivery)
        expect(message_delivery).to receive(:deliver)
        put :update, params: {trip_id: @trip, id: @gestion, status: 'approved' }
      end
      it "send email for a final state trip " do
        message_delivery = double(ActionMailer::MessageDelivery)
        expect(MainMailer).to receive(:livret_ready_email).with(@user, @trip).and_return(message_delivery)
        expect(message_delivery).to receive(:deliver)
        put :update, params: {trip_id: @trip, id: @gestion, status: 'final' }
      end
      it "redirect back" do
        put :update, params: {trip_id: @trip, id: @gestion }
        expect(response).to redirect_to "previous_location"
      end
    end
  end
end
