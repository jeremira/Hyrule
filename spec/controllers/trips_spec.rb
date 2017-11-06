require 'rails_helper'

describe TripsController  do

  describe "when logged in as an admin" do
  end

  describe "when logged in as an user" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:user)
      sign_in @user
      @user.trips << create(:trip)
    end
    describe "GET index" do
      it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end

  describe "when not logged in" do
    before :each do
      @trip = create(:trip)
    end
    it "can NOT access Trip#Index"do
      get :index
      expect(subject).to redirect_to('/users/sign_in')
    end
    it "can NOT access Trip#Show"do
      get :show, params: { id: @trip.id }
      expect(subject).to redirect_to('/users/sign_in')
    end
    it "can NOT access Trip#New"do
      get :new
      expect(subject).to redirect_to('/users/sign_in')
    end
    it "can NOT access Trip#Edit"do
      get :edit, params: { id: @trip.id }
      expect(subject).to redirect_to('/users/sign_in')
    end
    it "can NOT access Trip#Update"do
      put :update, params: { id: @trip.id }
      expect(subject).to redirect_to('/users/sign_in')
    end
    it "can NOT access Trip#Create"do
      post :create
      expect(subject).to redirect_to('/users/sign_in')
    end
    it "can NOT access Trip#Destroy"do
      delete :destroy, params: { id: @trip.id}
      expect(subject).to redirect_to('/users/sign_in')
    end
  end

end
