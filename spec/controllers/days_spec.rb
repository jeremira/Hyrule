require 'rails_helper'

describe DaysController  do
  before :each do
    @user = create(:user)
    @trip = create(:trip, user: @user)
    @gestion = create(:gestion, trip: @trip)
    @budget  = create(:budget, trip: @trip)
    @rythme  = create(:rythme, trip: @trip)
    @style   = create(:style, trip: @trip)
    @theme = create(:theme)
    @day = create(:day, trip: @trip, theme: @theme)
    @lunch = create(:lunch, day: @day)
    @dinner = create(:dinner, day: @day)
  end
#===============================================================================
#   GET /trips/:id/days/:id
#===============================================================================
  describe "GET show" do
    context 'when user is logged in' do
      before :each do
        sign_in @user
        get :show, params: { trip_id: @trip.id, id: @day.id }
      end
      it "grant access for logged in user" do
        expect(response.status).to eq(200)
      end
      it "render Show view" do
        expect(subject).to render_template(:show)
      end
      it "assign @day" do
        expect(assigns(:day)).to eq @day
      end
      it "assign @trip" do
        expect(assigns(:trip)).to eq @trip
      end
      it "assign @images" do
        @images = @day.theme.gallery.split(' ')
        @images.map! do |img|
          ActionController::Base.helpers.asset_url(img)
        end
        expect(assigns(:images)).to eq @images
      end
      it "can NOT see other user day" do
        @user2 = create(:user)
        @trip2 = create(:trip, user: @user2)
        @gestion2 = create(:gestion, trip: @trip2)
        @day2 = create(:day, trip: @trip2, theme: @theme)
        @lunch2 = create(:lunch, day: @day2)
        @dinner2 = create(:dinner, day: @day2)
        expect{get :show, params: { trip_id: @trip2.id, id: @day2.id }}.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context 'when admin is looged in' do
      it "can see other user day" do
        @admin = create(:user, admin: true)
        sign_in @admin
        get :show, params: { trip_id: @trip.id, id: @day.id }
        expect(response.status).to eq(200)
        expect(subject).to render_template(:show)
        expect(assigns(:day)).to eq @day
      end
    end
    context 'when user is logged out' do
      it "redirect not logged in user" do
        get :show, params: { trip_id: @trip.id, id: @day.id }
        expect(subject).to redirect_to('/users/sign_in')
      end
    end
  end
#===============================================================================
#  GET /trips/id:/days/new
#===============================================================================
  describe "GET new" do
    context "when user is logged in" do
      before :each do
        sign_in @user
        get :new, params: { trip_id: @trip.id, id: @day.id }
      end
      it "grant access for logged in user" do
        expect(response.status).to eq(200)
      end
      it "render New view" do
        expect(subject).to render_template(:new)
      end
      it "assign @day" do
        expect(assigns(:day)).to be_a_new Day
      end
      it "assign @trip" do
        expect(assigns(:trip)).to eq @trip
      end
      it "assign @themes" do
        expect(assigns(:themes)).to eq Theme.all
      end
      it "check if trip can be modified" do
        expect(controller).to receive(:trip_must_be_editable)
        get :new, params: { trip_id: @trip.id, id: @day.id }
      end
    end
    context "when user is logged out" do
      it "redirect not logged in user" do
        get :new, params: { trip_id: @trip}
        expect(subject).to redirect_to('/users/sign_in')
      end
    end
    context "when admin is logged in" do
      it "can create new day for an user" do
        @admin = create(:user, admin: true)
        sign_in @admin
        get :new, params: { trip_id: @trip}
        expect(response.status).to eq(200)
        expect(subject).to render_template(:new)
        expect(assigns(:day)).to be_a_new Day
      end
    end
  end
#===============================================================================
#   GET trips/:id/days/:id/edit
#===============================================================================
  describe "GET edit" do
    context "when user is logged in" do
      before :each do
        sign_in @user
        get :edit, params: { trip_id: @trip, id: @day }
      end
      it "grant access for logged in user" do
        expect(response.status).to eq(200)
      end
      it "render Edit view" do
        expect(subject).to render_template(:edit)
      end
      it "assign @day" do
        expect(assigns(:day)).to eq @day
      end
      it "assign @trip" do
        expect(assigns(:trip)).to eq @trip
      end
      it "assign @themes" do
        expect(assigns(:themes)).to eq Theme.all
      end
      it "check if trip can be modified" do
        expect(controller).to receive(:trip_must_be_editable)
        get :new, params: { trip_id: @trip.id, id: @day.id }
      end
    end
    context "when user is logged out" do
      it "redirect not logged in user" do
        get :edit, params: { trip_id: @trip, id: @day}
        expect(subject).to redirect_to('/users/sign_in')
      end
    end
    context "when admin is logged in" do
      it "can edit day for an user" do
        @admin = create(:user, admin: true)
        sign_in @admin
        get :edit, params: { trip_id: @trip, id: @day}
        expect(response.status).to eq(200)
        expect(subject).to render_template(:edit)
        expect(assigns(:day)).to eq @day
      end
    end
  end
#===============================================================================
#  POST /trips/:id/days
#===============================================================================
  describe "POST create" do
    context "when user is logged in" do
      before :each do
        sign_in @user
      end
      it "assign @trip" do
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        post :create, params: @params
        expect(assigns(:trip)).to eq @trip
      end
      it "check if day is editable" do
        expect(controller).to receive(:trip_must_be_editable)
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        post :create, params: @params
      end
      it "create a new Day record for a New trip" do
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to change(Day, :count).by(1)
      end
      it "redirect to the Day Show page" do
          @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
          expect(post :create, params: @params).to redirect_to([@trip, Day.last])
      end
      it "set up a flash message" do
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        post :create, params: @params
        expect(flash[:notice]).to eq "Une journée a été ajoutée à votre séjour."
      end
      it "create a new Day record for a New trip" do
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to change(Day, :count).by(1)
      end
      it "do NOT create a new Day record for a Pending trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'Pending')
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to_not change(Day, :count)
        expect(flash[:alert]).to eq "Vous ne pouvez pas modifier ce voyage."
        expect(subject).to redirect_to '/trips'
      end
      it "do NOT create a new Day record for a Approved trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'Approved')
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to_not change(Day, :count)
        expect(flash[:alert]).to eq "Vous ne pouvez pas modifier ce voyage."
        expect(subject).to redirect_to '/trips'
      end
      it "do NOT create a new Day record for a Payed trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'Payed')
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to_not change(Day, :count)
        expect(flash[:alert]).to eq "Vous ne pouvez pas modifier ce voyage."
        expect(subject).to redirect_to '/trips'
      end
      it "do NOT create a new Day record for a Final trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'Final')
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to_not change(Day, :count)
        expect(flash[:alert]).to eq "Vous ne pouvez pas modifier ce voyage."
        expect(subject).to redirect_to '/trips'
      end
      it "do NOT create a new Day record for an invalid status trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'bachibouzouk')
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{ post :create, params: @params }.to_not change(Day, :count)
        expect(flash[:alert]).to eq "Vous ne pouvez pas modifier ce voyage."
        expect(subject).to redirect_to '/trips'
      end
      it "dont create a new record with invalid params" do
        @invalid_params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: 'invalid', trip_id: @trip) }
        expect{ post :create, params: @invalid_params }.to_not change(Day, :count)
        expect(flash[:alert]).to eq "Une erreur s'est produite. Votre journée n'a pas été enregistrée"
        expect(subject).to render_template 'new'
      end
      it "cant create a new record for another user" do
        @user2 = create(:user)
        sign_in @user2
        @params_for_user1 = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: 'invalid', trip_id: @trip) }
        expect{ post :create, params: @params_for_user1 }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context "when user is not logged in" do
      it "redirect not logged in user" do
        post :create, params: { trip_id: @trip, day: FactoryBot.attributes_for(:day) }
        expect(subject).to redirect_to('/users/sign_in')
      end
    end
    context "when admin is logged in" do
      it "can create day for any user" do
        @admin = create(:user, admin: true)
        sign_in @admin
        @params = { trip_id: @trip, day: FactoryBot.attributes_for(:day, theme_id: @theme, trip_id: @trip) }
        expect{post :create, params: @params}.to change(@trip.days, :count).by(1)
      end
    end
  end
#===============================================================================
#    PUT /trips/id:/days/:id
#===============================================================================
  describe "PUT update" do
    context "when user is logged in" do
      before :each do
        sign_in @user
        @new_date = Date.new(2020,1,1)
      end
      it "assign @trip" do
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        expect(assigns(:trip)).to eq @trip
      end
      it "assign @day" do
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        expect(assigns(:day)).to eq @day
      end
      it "check if day is editable" do
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        expect(controller).to receive(:trip_must_be_editable)
        put :update, params: @params
      end
      it "assign @themes" do
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        expect(assigns(:themes)).to eq Theme.all
      end
      it "do update day for New trip" do
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(@day.date).to eq @new_date
      end
      it "setup a flash message" do
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(flash[:notice]).to eq "Changements enregistrés."
      end
      it "do NOT update day for pending trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'pending')
        @day = create(:day, trip: @trip, theme: @theme)
        same_old_date = @day.date
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(@day.date).to eq same_old_date
      end
      it "do NOT update day for approved trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'approved')
        @day = create(:day, trip: @trip, theme: @theme)
        same_old_date = @day.date
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(@day.date).to eq same_old_date
      end
      it "do NOT update day for payed trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'payed')
        @day = create(:day, trip: @trip, theme: @theme)
        same_old_date = @day.date
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(@day.date).to eq same_old_date
      end
      it "do NOT update day for final trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'pending')
        @day = create(:day, trip: @trip, theme: @theme)
        same_old_date = @day.date
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(@day.date).to eq same_old_date
      end
      it "do NOT update day of another user" do
        @user2 = create(:user)
        sign_in @user2
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        expect{ put :update, params: @params }.to raise_exception(ActiveRecord::RecordNotFound)
      end
      it "do NOT update day with invalid params" do
        @params = { trip_id: @trip, id: @day.id, day: { theme_id: 'invalid' } }
        put :update, params: @params
        @day.reload
        expect(@day.theme.name).to eq 'default'
        expect(flash[:alert]).to eq "Les changements n'ont pas pu être enregistrés."
        expect(subject).to render_template 'edit'
      end
    end
    context "when user is not logged in" do
      it "redirect not logged in user" do
        get :edit, params: { trip_id: @trip, id: @day}
        expect(subject).to redirect_to('/users/sign_in')
      end
    end
    context "when admin is logged in" do
      it "can update any user trip" do
        @admin = create(:user, admin: true)
        @new_date = Date.new(2020,1,1)
        sign_in @admin
        @params = { trip_id: @trip, id: @day.id, day: { date: @new_date } }
        put :update, params: @params
        @day.reload
        expect(@day.date).to eq @new_date
      end
    end
  end
#===============================================================================
#    DELETE /trips/:id/days/:id
#===============================================================================
  describe "DELETE destroy" do
    context "when user is logged in" do
      before :each do
        sign_in @user
      end
      it "assign @day" do
        delete :destroy, params: { trip_id: @trip, id: @day }
        expect(assigns :day).to eq @day
      end
      it "assign @trip" do
        delete :destroy, params: { trip_id: @trip, id: @day }
        expect(assigns :trip).to eq @trip
      end
      it "check if the record is deletable" do
        expect(controller).to receive :trip_must_be_editable
        delete :destroy, params: { trip_id: @trip, id: @day }
      end
      it "can destroy a day for new trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'new')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to change{Day.count}.by(-1)
        expect(flash[:notice]).to eq 'Cette journée a bien été supprimée.'
        expect(subject).to redirect_to @trip
      end
      it "can not destroy a day for a pending trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'pending')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to_not change{Day.count}
        expect(flash[:alert]).to eq 'Vous ne pouvez pas modifier ce voyage.'
        expect(subject).to redirect_to '/trips'
      end
      it "can NOT destroy a day for an approved trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'approved')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to_not change{Day.count}
        expect(flash[:alert]).to eq 'Vous ne pouvez pas modifier ce voyage.'
        expect(subject).to redirect_to '/trips'
      end
      it "can NOT destroy a day for a payed trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'payed')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to_not change{Day.count}
        expect(flash[:alert]).to eq 'Vous ne pouvez pas modifier ce voyage.'
        expect(subject).to redirect_to '/trips'
      end
      it "can NOT destroy a day for a final trip" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'pending')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to_not change{Day.count}
        expect(flash[:alert]).to eq 'Vous ne pouvez pas modifier ce voyage.'
        expect(subject).to redirect_to '/trips'
      end
      it "can NOT destroy a day record from another user" do
        @user2 = create(:user)
        sign_in @user2
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
    context "when user is not logged in" do
      it "redirect not logged in user" do
        delete :destroy, params: { trip_id: @trip, id: @day }
        expect(subject).to redirect_to('/users/sign_in')
      end
      it "does not delete any record" do
        delete :destroy, params: { trip_id: @trip, id: @day }
        expect{subject}.to_not change(Day, :count)
      end
    end
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "check if the record is deletable" do
        expect(controller).to receive :trip_must_be_editable
        delete :destroy, params: { trip_id: @trip, id: @day }
      end
      it "can destroy a new trip record" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'new')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to change{Day.count}.by(-1)
        expect(flash[:notice]).to eq 'Cette journée a bien été supprimée.'
        expect(subject).to redirect_to @trip
      end
      it "can destroy a pending trip record" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'pending')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to change{Day.count}.by(-1)
        expect(flash[:notice]).to eq 'Cette journée a bien été supprimée.'
        expect(subject).to redirect_to @trip
      end
      it "can destroy a approved trip record" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'approved')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to change{Day.count}.by(-1)
        expect(flash[:notice]).to eq 'Cette journée a bien été supprimée.'
        expect(subject).to redirect_to @trip
      end
      it "can destroy a payed trip record" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'payed')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to change{Day.count}.by(-1)
        expect(flash[:notice]).to eq 'Cette journée a bien été supprimée.'
        expect(subject).to redirect_to @trip
      end
      it "can destroy a final trip record" do
        @trip = create(:trip, user: @user)
        @gestion = create(:gestion, trip: @trip, status: 'final')
        @day = create(:day, trip: @trip, theme: @theme)
        expect{delete :destroy, params: { trip_id: @trip, id: @day }}.to change{Day.count}.by(-1)
        expect(flash[:notice]).to eq 'Cette journée a bien été supprimée.'
        expect(subject).to redirect_to @trip
      end
    end
  end
end
