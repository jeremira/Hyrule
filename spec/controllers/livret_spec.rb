require 'rails_helper'

describe LivretsController  do
  before :each do
    @livret = create(:livret)
  end
#===============================================================================
#  GET /livrets/
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
#   GET /livret/:id
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
#  GET /livret/new
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
#   GET livrets/:id/edit
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
#  POST /livrets/
#===============================================================================
  describe "POST create" do
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        @trip = create(:trip)
        @htmlbook = fixture_file_upload("#{Rails.root}/spec/support/fixtures/book.html", 'text/html')
        sign_in @admin
      end
      context "with valid params" do
        it "create a new livret" do
          params = FactoryBot.attributes_for(:livret, trip_id: @trip.id, htmlbook: @htmlbook)
          expect {
            post :create, params: { livret: params }
          }.to change(Livret, :count).by(1)
        end
        it "redirect to livret show page" do
          params = FactoryBot.attributes_for(:livret, trip_id: @trip.id, htmlbook: @htmlbook)
          expect(
            post :create, params: { livret: params }
          ).to redirect_to Livret.last
        end
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
#    PUT /livrets/id:
#===============================================================================
  describe "PUT update" do
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        @trip = create(:trip)
        @livret = create(:livret, trip: @trip)
        @htmlbook = fixture_file_upload("#{Rails.root}/spec/support/fixtures/book.html", 'text/html')
        sign_in @admin
      end
      context "with valid params" do
        it "update livret" do
          other_book = fixture_file_upload("#{Rails.root}/spec/support/fixtures/other_book.html", 'text/html')
          params = FactoryBot.attributes_for(:livret, trip_id: @trip.id, htmlbook: other_book)
          put :update, params: { id: @livret, livret: params }
          expect(@livret.reload.htmlbook_file_name).to eq 'other_book.html'
        end
        it "redirect to livret show page" do
          other_book = fixture_file_upload("#{Rails.root}/spec/support/fixtures/other_book.html", 'text/html')
          params = FactoryBot.attributes_for(:livret, trip_id: @trip.id, htmlbook: other_book)
          expect(put :update, params: { id: @livret, livret: params }).to redirect_to @livret
        end
      end
    end
    context "when user is logged in" do
      it "redirect to root page" do
        @user = create(:user)
        sign_in @user
        @trip = create(:trip, user: @user)
        @livret = create(:livret, trip: @trip)
        params = FactoryBot.attributes_for(:livret, trip_id: @trip.id)
        expect(put :update, params: { id: @livret, livret: params }).to redirect_to root_path
      end
    end
    context "when logged out" do
      it "redirect to  sign in page" do
        @trip = create(:trip)
        @livret = create(:livret, trip: @trip)
        params = FactoryBot.attributes_for(:livret, trip_id: @trip.id)
        expect(put :update, params: { id: @livret, livret: params }).to redirect_to new_user_session_path
      end
    end
  end
#===============================================================================
#    DELETE /trips/:id
#===============================================================================
  describe "DELETE destroy" do
      context "when admin is logged in" do
        before :each do
          @admin = create(:user, admin: true)
          @trip = create(:trip)
          @livret = create(:livret, trip: @trip)
          sign_in @admin
        end
        context "with valid params" do
          it "delete livret" do
            expect{delete :destroy, params: { id: @livret }}.to change(Livret, :count).by(-1)
          end
          it "redirect to root page" do
            expect(delete :destroy, params: { id: @livret }).to redirect_to root_path
          end
        end
      end
      context "when user is logged in" do
        it "redirect to root page" do
          @user = create(:user)
          @trip = create(:trip, user: @user)
          @livret = create(:livret, trip: @trip)
          sign_in @user
          expect(delete :destroy, params: { id: @livret }).to redirect_to root_path
        end
        it "do not delete record" do
          @user = create(:user)
          @trip = create(:trip, user: @user)
          @livret = create(:livret, trip: @trip)
          expect{delete :destroy, params: { id: @livret }}.to_not change(Livret, :count)
        end
      end
      context "when logged out" do
        it "redirect to root page" do
          @user = create(:user)
          @trip = create(:trip, user: @user)
          @livret = create(:livret, trip: @trip)
          sign_in @user
          expect(delete :destroy, params: { id: @livret }).to redirect_to root_path
        end
        it "do not delete record" do
          @user = create(:user)
          @trip = create(:trip, user: @user)
          @livret = create(:livret, trip: @trip)
          expect{delete :destroy, params: { id: @livret }}.to_not change(Livret, :count)
        end
      end
  end

  describe "GET mappath"do
    context "when logged in" do
      context "with valid params" do
        before :each do
          @user =create(:user)
          sign_in @user
          @livret = create(:livret, :with_maps)
          get :mappath, :format => :json, params: { livret: @livret.id, map: 'map.jpg' }
        end
        it "response succesfully" do
          expect(response).to be_success
        end
        it "return a json object" do
          expect(response.content_type).to eq("application/json")
        end
        it "return map url" do
          map_url = {path: @livret.assets.first.map.url}
          map_url = map_url.to_json
          expect(response.body).to eq map_url
        end
      end
      context "with invalid livret_id params" do
        before :each do
          @user =create(:user)
          sign_in @user
          @livret = create(:livret, :with_maps)
          get :mappath, :format => :json, params: { livret: 'invalid', map: 'map.jpg' }
        end
        it "response succesfully" do
          expect(response).to be_success
        end
        it "return a json object" do
          expect(response.content_type).to eq("application/json")
        end
        it "return correct error message" do
          error_json = ({path: "No livret found : L-invalid F-map.jpg"}).to_json
          expect(response.body).to eq error_json
        end
      end
      context "with invalid map_file_name params" do
        before :each do
          @user =create(:user)
          sign_in @user
          @livret = create(:livret, :with_maps)
          get :mappath, :format => :json, params: { livret: @livret.id, map: 'invalid' }
        end
        it "response succesfully" do
          expect(response).to be_success
        end
        it "return a json object" do
          expect(response.content_type).to eq("application/json")
        end
        it "return correct error message" do
          error_json = ({path: "No map found : L-#{@livret.id} F-invalid"}).to_json
          expect(response.body).to eq error_json
        end
      end
    end
    context "when logged out" do
      it "deny access" do
          @livret = create(:livret, :with_maps)
          get :mappath, :format => :json, params: { livret: @livret.id, map: 'map.jpg' }
          expect(response).to_not be_success
      end
    end
  end

  describe "GET preview" do
    it "response succesfully" do
      expect(get :preview).to be_success
    end
    it "render preview view" do
      expect(get :preview).to render_template :preview
    end
  end
end
