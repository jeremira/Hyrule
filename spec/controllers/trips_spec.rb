require 'rails_helper'

describe TripsController  do

    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = create(:user)
      @trip = create(:trip, user: @user)
      @gestion = create(:gestion, trip: @trip)
      @budget  = create(:budget, trip: @trip)
      @rythme  = create(:rythme, trip: @trip)
      @style   = create(:style, trip: @trip)
    end

    describe "GET index" do
      context 'when user is logged in' do
        before :each do
          sign_in @user
          get :index
        end
        it "grant access for logged in user" do
          expect(response.status).to eq(200)
        end
        it "render Index view" do
          expect(subject).to render_template(:index)
        end
        it "assign @trips" do
          expect(assigns(:trips)).to eq(@user.trips)
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          get :index
          expect(subject).to redirect_to('/users/sign_in')
        end
      end
    end

    describe "GET show" do
      context 'when user is logged in' do
        before :each do
          sign_in @user
          get :show, params: { id: @trip.id }
        end
        it "grant access for logged in user" do
          expect(response.status).to eq(200)
        end
        it "render Show view" do
          expect(subject).to render_template(:show)
        end
        it "assign @trip" do
          expect(assigns(:trip)).to eq(@trip)
        end
        it "assign @days" do
          create(:day, trip: @trip)
          expect(assigns(:days)).to eq(@trip.days)
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          get :show, params: { id: @trip.id }
          expect(subject).to redirect_to('/users/sign_in')
        end
      end
    end

    describe "GET new" do
      context 'when user is logged in' do
        before :each do
          sign_in @user
          get :new
        end
        it "grant access for logged in user" do
          expect(response.status).to eq(200)
        end
        it "render New view" do
          expect(subject).to render_template(:new)
        end
        it "build a new trip with dependancies" do
          expect(assigns(:trip)).to be_a_new(Trip)
          expect(assigns(:trip).budget).to be_a_new(Budget)
          expect(assigns(:trip).rythme).to be_a_new(Rythme)
          expect(assigns(:trip).style).to be_a_new(Style)
          expect(assigns(:trip).gestion).to be_a_new(Gestion)
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          get :new
          expect(subject).to redirect_to('/users/sign_in')
        end
      end
    end


    describe "GET edit" do
      context 'when user is logged in' do
        before :each do
          sign_in @user
          get :edit, params: { id: @trip.id }
        end
        it "grant access for logged in user" do
          expect(response.status).to eq(200)
        end
        it "render Show view" do
          expect(subject).to render_template(:edit)
        end
        it "assign @trip" do
          expect(assigns(:trip)).to eq(@trip)
        end
        it "check if its editable" do
          expect(controller).to receive(:can_edit_it?)
          get :edit, params: { id: @trip.id }
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          get :edit, params: { id: @trip.id }
          expect(subject).to redirect_to('/users/sign_in')
        end
      end
    end

    describe "POST create" do
      context 'when a logged in user post valid params' do
        before :each do
          sign_in @user
          @trip_params = FactoryBot.attributes_for(:trip)
        end
        it "create a new Trip record" do
          expect{ post :create, params: { trip: @trip_params } }.to change(Trip, :count).by(1)
        end
        it "redirect to the new Trip Show page" do
          expect(post :create, params: { trip: @trip_params }).to redirect_to(Trip.last)
        end
        it "set up a flash message" do
          post :create, params: { trip: @trip_params }
          expect(flash[:notice]).to eq "Votre nouveau séjour a bien été créé."
        end
      end
      context 'when a logged in user post INvalid params' do
        before :each do
          sign_in @user
          @invalid_trip = FactoryBot.attributes_for(:trip, adults: nil)
        end
        it "do NOT create a new Trip record" do
          expect{ post :create, params: { trip: @invalid_trip } }.to_not change{Trip.count}
        end
        it "render Trip New page again" do
          expect(post :create, params: { trip: @invalid_trip }).to render_template :new
        end
        it "set up an error Flash message" do
          post :create, params: { trip: @invalid_trip }
          expect(flash[:alert]).to eq "Votre séjour n'a pas pu être enregistré."
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          @trip_params = FactoryBot.attributes_for(:trip)
          post :create, params: { trip: @trip_params }
          expect(subject).to redirect_to('/users/sign_in')
        end
      end
    end


end
