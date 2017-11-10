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
#===============================================================================
#  GET /trips/
#===============================================================================
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
#===============================================================================
#   GET /trip/:id
#===============================================================================
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
#===============================================================================
#  GET /trips/new
#===============================================================================
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
#===============================================================================
#   GET trips/:id/edit
#===============================================================================
    describe "GET edit" do
      context 'when user is logged in' do
        before :each do
          sign_in @user
          get :edit, params: { id: @trip.id }
        end
        it "grant access for logged in user" do
          expect(response.status).to eq(200)
        end
        it "render Edit view" do
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
#===============================================================================
#  POST /trips/
#===============================================================================
    describe "POST create" do
      context 'when a logged in user post valid params' do
        before :each do
          sign_in @user
          @trip_params = FactoryBot.attributes_for(:trip)
        end
        it "create a new Trip record" do
          expect{post :create, params: { trip: @trip_params }}.to change(Trip, :count).by(1)

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
          post :create, params: { trip: FactoryBot.attributes_for(:trip) }
          expect(subject).to redirect_to('/users/sign_in')
        end
        it "do NOT create a new Trip record" do
          expect{ post :create, params: { trip: FactoryBot.attributes_for(:trip) } }.to_not change{Trip.count}
        end
      end
    end
#===============================================================================
#    PUT /trips/id:
#===============================================================================
    describe "PUT update" do
      context "when user is logged in" do
        before :each do
          sign_in @user
        end
        it "check if the record is editable" do
          expect(controller).to receive :can_edit_it?
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
        end
        it "can edit a new trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'new')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
        it "can NOT edit a pending trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'pending')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Mon voyage à Tokyo"
          expect(subject).to redirect_to '/'
          expect(flash[:alert]).to eq "Les changements apportés à votre séjour n'ont pas pu être enregistrés."
        end
        it "can NOT edit a approved trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'approved')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Mon voyage à Tokyo"
          expect(subject).to redirect_to '/'
          expect(flash[:alert]).to eq "Les changements apportés à votre séjour n'ont pas pu être enregistrés."
        end
        it "can NOT edit a payed trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'payed')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Mon voyage à Tokyo"
          expect(subject).to redirect_to '/'
          expect(flash[:alert]).to eq "Les changements apportés à votre séjour n'ont pas pu être enregistrés."
        end
        it "can NOT edit a final trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'final')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Mon voyage à Tokyo"
          expect(subject).to redirect_to '/'
          expect(flash[:alert]).to eq "Les changements apportés à votre séjour n'ont pas pu être enregistrés."
        end
        it "can NOT edit a trip record from another user" do
          @user2 = create(:user)
          @trip2 = create(:trip, user: @user2)
          @gestion2 = create(:gestion, trip: @trip2)
          expect{put :update, params: { id: @trip2.id, trip: { name: 'Updated trip name'} }}.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
      context "when admin is logged in" do
        before :each do
          @admin = create(:user, admin: true)
          sign_in @admin
        end
        it "check if the record is editable" do
          expect(controller).to receive :can_edit_it?
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
        end
        it "can edit a new trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'new')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
        it "can edit a pending trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'pending')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
        it "can edit a approved trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'approved')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
        it "can edit a payed trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'payed')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
        it "can edit a final trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'final')
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
      end
      context 'when a logged in user update valid params' do
        before :each do
          sign_in @user
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
          @trip.reload
        end
        it "assign @trip" do
          expect(assigns(:trip)).to eq(@trip)
        end
        it "check if its editable" do
          expect(controller).to receive(:can_edit_it?)
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name'} }
        end
        it "update @trip record" do
          expect(@trip.name).to eq "Updated trip name"
          expect(subject).to redirect_to @trip
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
        it "redirect to @trip" do
          expect(subject).to redirect_to @trip
        end
        it "setup flash message" do
          expect(flash[:notice]).to eq "Changements enregistrés"
        end
      end
      context 'when a logged in user update INvalid params' do
        before :each do
          sign_in @user
          put :update, params: { id: @trip.id, trip: { name: 'Updated trip name', adults: nil} }
          @trip.reload
        end
        it "assign @trip" do
          expect(assigns(:trip)).to eq(@trip)
        end
        it "do not update @trip record" do
          expect(@trip.name).to eq "Mon voyage à Tokyo" #default trip name
        end
        it "render Edit action" do
          expect(subject).to render_template :edit
        end
        it "setup flash message" do
          expect(flash[:alert]).to eq "Les changements apportés à votre séjour n'ont pas pu être enregistrés."
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          put :update, params: { id: @trip.id, trip: FactoryBot.attributes_for(:trip) }
          expect(subject).to redirect_to('/users/sign_in')
        end
        it "do not update @trip record" do
          put :update, params: { id: @trip.id, trip: FactoryBot.attributes_for(:trip) }
          expect(@trip.name).to eq "Mon voyage à Tokyo" #default trip name
        end
      end
    end
#===============================================================================
#    DELETE /trips/:id
#===============================================================================
    describe "DELETE destroy" do
      context "when user is logged in" do
        before :each do
          sign_in @user
        end
        it "check if the record is deletable" do
          expect(controller).to receive :can_delete_it?
          delete :destroy, params: { id: @trip.id }
        end
        it "can destroy a new trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'new')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a pending trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'pending')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a approved trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'approved')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can NOT destroy a payed trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'payed')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(0)
          expect(flash[:alert]).to eq 'Vous ne pouvez pas supprimer ce voyage.'
          expect(subject).to redirect_to '/'
        end
        it "can NOT destroy a final trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'final')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(0)
          expect(flash[:alert]).to eq 'Vous ne pouvez pas supprimer ce voyage.'
          expect(subject).to redirect_to '/'
        end
        it "can NOT destroy a trip record from another user" do
          @trip.gestion.status = 'new'
          @trip.save
          @user2 = create(:user)
          @trip2 = create(:trip, user: @user2)
          @gestion2 = create(:gestion, trip: @trip2)
          @budget2  = create(:budget, trip: @trip2)
          @rythme2  = create(:rythme, trip: @trip2)
          @style2   = create(:style, trip: @trip2)
          expect{delete :destroy, params: { id: @trip2.id }}.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
      context "when admin is logged in" do
        before :each do
          @admin = create(:user, admin: true)
          sign_in @admin
        end
        it "check if the record is deletable" do
          expect(controller).to receive :can_delete_it?
          delete :destroy, params: { id: @trip.id }
        end
        it "can destroy a new trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'new')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a pending trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'pending')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a approved trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'approved')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a payed trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'payed')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a final trip record" do
          @trip = create(:trip, user: @user)
          @gestion = create(:gestion, trip: @trip, status: 'final')
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
        it "can destroy a trip record from another user" do
          @user2 = create(:user)
          @trip2 = create(:trip, user: @user2)
          @gestion2 = create(:gestion, trip: @trip2)
          expect{delete :destroy, params: { id: @trip.id }}.to change{Trip.count}.by(-1)
          expect(flash[:notice]).to eq 'Ce voyage a été supprimé.'
          expect(subject).to redirect_to '/trips'
        end
      end
      context 'when user is logged out' do
        it "redirect not logged in user" do
          delete :destroy, params: { id: @trip.id }
          expect(subject).to redirect_to('/users/sign_in')
        end
        it "do NOT destroy @trip record" do
          expect{ delete :destroy, params: { id: @trip.id } }.to_not change{ Trip.count }
        end
      end
    end
end
