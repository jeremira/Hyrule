require 'rails_helper'

describe LivretsController  do
  before :each do
    @livret = create(:livret)
  end
#===============================================================================
#  GET /trips/
#===============================================================================
  describe "GET index" do
    context "when user is logged in" do
      it "redirect to root page" do
        @user = create(:user)
        sign_in @user
        expect(get :index).to redirect_to root_path
      end
    end
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "respond succesfully" do
        expect(get :index).to be_success
      end
      it "assign @themes" do
        get :index
        expect(assigns :livrets).to eq Livret.all
      end
    end
    context "when user is logged out" do
      it "redirect to sign in page" do
        expect(get :index).to redirect_to new_user_session_path
      end
    end
  end
#===============================================================================
#   GET /trip/:id
#===============================================================================
  describe "GET show" do
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
        sign_in @admin
      end
      it "can see other user livret" do
        expect(get :show, params: {id: @livret}).to be_success
      end
      it "assign @livret" do
        get :show, params: {id: @livret}
        expect(assigns :livret).to eq @livret
      end
      it "assign @maps" do
        get :show, params: {id: @livret}
        expect(assigns :maps).to eq @livret.assets
      end
      it "assign @trip" do
        get :show, params: {id: @livret}
        expect(assigns :trip).to eq @livret.trip
      end
      it "render show view" do
        expect(get :show, params: {id: @livret}).to render_template :show
      end
    end
    context "when user is logged in" do
      before :each do
        @user = create(:user)
        @trip = create(:trip, user: @user)
        sign_in @user
      end
      context "and check his own livret" do
        before :each do
          @livret = create(:livret, trip: @trip)
        end
        it "response succesfully" do
          expect(get :show, params: {id: @livret}).to be_success
        end
        it "assign @livret" do
          get :show, params: {id: @livret}
          expect(assigns :livret).to eq @livret
        end
        it "assign @maps" do
          get :show, params: {id: @livret}
          expect(assigns :maps).to eq @livret.assets
        end
        it "assign @trip" do
          get :show, params: {id: @livret}
          expect(assigns :trip).to eq @livret.trip
        end
        it "render show view" do
          expect(get :show, params: {id: @livret}).to render_template :show
        end
      end
      context "and check another user livret" do
        it "redirect to root" do
          @livret = create(:livret)
          expect(get :show, params: {id: @livret}).to redirect_to root_path
        end
      end
    end
    context "when logged out" do
      it "redirect to sign in page" do
        expect(get :show, params: { id: @livret}).to redirect_to new_user_session_path
      end
    end
  end
#===============================================================================
#  GET /trips/new
#===============================================================================
  describe "GET new" do
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
      end
      it "grant access" do
        expect(get :new, params: {trip_id: @trip}).to be_success
      end
      it "render new view" do
        expect(get :new, params: {trip_id: @trip}).to render_template :new
      end
      it "assign @trip" do
        get :new, params: {trip_id: @trip}
        expect(assigns :trip).to eq @trip
      end
      it "build new livret" do
        get :new, params: {trip_id: @trip}
        expect(assigns :livret).to be_a_new Livret
      end
    end
    context "when user is logged in" do
      it "redirect to root path" do
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
        sign_in @user
        expect(get :new, params: {trip_id: @trip}).to redirect_to root_path
      end
    end
    context "when logged out" do
      it "redirect to sign in path" do
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
        expect(get :new, params: {trip_id: @trip}).to redirect_to new_user_session_path
      end
    end
  end
#===============================================================================
#   GET trips/:id/edit
#===============================================================================
  describe "GET edit" do
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip)
        @livret = create(:livret, trip: @trip)
      end
      it "grant access" do
        expect(get :edit, params: {id: @livret }).to be_success
      end
      it "render edit view" do
        expect(get :edit, params: {id: @livret }).to render_template :edit
      end
      it "assign @livret" do
        get :edit, params: {id: @livret }
        expect(assigns :livret).to eq @livret
      end
      it "assign @trip" do
        get :edit, params: {id: @livret }
        expect(assigns :trip).to eq @trip
      end
    end
    context "when user is logged in" do
      it "redirect to root path" do
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
        sign_in @user
        expect(get :edit, params: {id: @livret }).to redirect_to root_path
      end
    end
    context "when logged out" do
      it "redirect to sign in path" do
        @user = create(:user)
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
        expect(get :edit, params: {id: @livret }).to redirect_to new_user_session_path
      end
    end
  end
#===============================================================================
#  POST /trips/
#===============================================================================
  describe "POST create" do
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "grant access"
      it "redirect to livret show page"
      context "with valid params" do
        it "create a new livret"
        it "redirect to livret show page"
      end
      context "with invalid params" do
        it "do NOT create a new livret"
        it "render new view"
      end
    end
    context "when user is logged in" do
      it "redirect to root page" do
        @user = create(:user)
        sign_in @user
        @params = FactoryBot.attributes_for(:livret)
        expect( post :create, params:  @params ).to redirect_to root_path
      end
    end
    context "when logged out" do
      it "redirect to  sign in page" do
        @params = FactoryBot.attributes_for(:livret)
        expect( post :create, params:  @params ).to redirect_to new_user_session_path
      end
    end
  end
#===============================================================================
#    PUT /trips/id:
#===============================================================================
  describe "PUT update" do
  end
#===============================================================================
#    DELETE /trips/:id
#===============================================================================
  describe "DELETE destroy" do
  end
end
