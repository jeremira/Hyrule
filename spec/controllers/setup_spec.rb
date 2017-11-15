require 'rails_helper'

describe SetupController  do
#===============================================================================
#  GET /trips/
#===============================================================================
  describe "GET index" do
    context "when user is logged in" do
      it "redirect normal user to root page" do
        @user = create(:user)
        sign_in @user
        expect(get :index).to redirect_to '/'
      end
    end
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "has a 200 status code" do
        get :index
        expect(response).to have_http_status 200
      end
      it "assign @themes" do
        create(:theme)
        get :index
        expect(assigns :themes).to eq Theme.all
      end
      it "assign @users_registered" do
        create(:user)
        create(:user)
        get :index
        expect(assigns :users_registered).to eq User.count
      end
      it "assign @all_trips" do
        10.times { create(:trip, :with_gestion) }
        get :index
        expect(assigns :all_trips).to eq Trip.all
      end
      it "assign @trips_total" do
        10.times { create(:trip, :with_gestion) }
        get :index
        expect(assigns :trips_total).to eq Trip.count
      end
      it "assign @last_trips" do
        10.times { create(:trip, :with_gestion) }
        get :index
        expect(assigns :last_trips).to eq Trip.last(5)
      end
      it "assign @pending_trip" do
        3.times { create(:trip, :with_gestion) }
        @pending = create(:gestion, status: 'pending')
        get :index
        expect(assigns :pending_trips).to eq [@pending.trip]
      end
      it "assign @payed_trip" do
        3.times { create(:trip, :with_gestion) }
        @payed = create(:gestion, status: 'payed')
        get :index
        expect(assigns :payed_trips).to eq [@payed.trip]
      end
      it "assign @final_trip" do
        3.times { create(:trip, :with_gestion) }
        @final = create(:gestion, status: 'final')
        get :index
        expect(assigns :final_trips).to eq [@final.trip]
      end
    end
    context "when user is logged out" do
      it "redirect to root page" do
        expect(get :index).to redirect_to '/'
      end
    end
  end
end
