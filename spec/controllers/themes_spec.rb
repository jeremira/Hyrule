require 'rails_helper'

describe ThemesController  do
  before :each do
    @theme = create(:theme)
  end
#===============================================================================
#  GET /trips/
#===============================================================================
  describe "GET index" do
    it "respond successfully" do
      get :index
      expect(response).to be_success
    end
    it "assign @themes" do
      get :index
      expect(assigns :themes).to eq Theme.all
    end
  end
#===============================================================================
#   GET /trip/:id
#===============================================================================
  describe "GET show" do
    it "respond successfully" do
      get :show, params: {id: @theme}
      expect(response).to be_success
    end
    it "assign @theme" do
      get :show, params: {id: @theme}
      expect(assigns :theme).to eq @theme
    end
  end
#===============================================================================
#  GET /trips/new
#===============================================================================
  describe "GET new" do
    context "when logged in" do
      it "redirect to root" do
        @user = create(:user)
        sign_in @user
        get :new
        expect(response).to redirect_to '/'
      end
    end
    context "when logged out" do
      it "redirect to root" do
        get :new
        expect(response).to redirect_to '/'
      end
    end
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "respond successfully" do
        get :new
        expect(response).to be_success
      end
      it "assign @theme" do
        get :new
        expect(assigns :theme).to be_a_new Theme
      end
    end
  end
#===============================================================================
#   GET trips/:id/edit
#===============================================================================
  describe "GET edit" do
    context "when logged in" do
      it "redirect to root" do
        @user = create(:user)
        sign_in @user
        get :edit, params: { id: @theme}
        expect(response).to redirect_to '/'
      end
    end
    context "when logged out" do
      it "redirect to root" do
        get :edit, params: { id: @theme}
        expect(response).to redirect_to '/'
      end
    end
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      it "respond successfully" do
        get :edit, params: { id: @theme}
        expect(response).to be_success
      end
      it "assign @theme" do
        get :edit, params: { id: @theme}
        expect(assigns :theme).to eq @theme
      end
    end
  end
#===============================================================================
#  POST /trips/
#===============================================================================
  describe "POST create" do
    context "when logged in" do
      it "redirect to root" do
        @user = create(:user)
        sign_in @user
        @params = FactoryBot.attributes_for :theme
        post :create, params: { theme: @params }
        expect(response).to redirect_to '/'
      end
    end
    context "when logged out" do
      it "redirect to root" do
        @params = FactoryBot.attributes_for :theme
        post :create, params: { theme: @params }
        expect(response).to redirect_to '/'
      end
    end
    context "when admin logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
        @params = FactoryBot.attributes_for(:theme)
      end
      context "with valid params" do
        it "create a new theme" do
          expect{ post :create, params: { theme: @params } }.to change(Theme, :count).by(1)
        end
        it "redirect to the new theme" do
          expect(post :create, params: { theme: @params }).to redirect_to Theme.last
        end
      end
      context "with invalid params" do
        it "do NOT create a new theme" do
          @params[:name] = nil
          expect{ post :create, params: { theme: @params } }.to_not change(Theme, :count)
        end
        it "render the new view" do
          @params[:name] = nil
          expect(post :create, params: { theme: @params }).to render_template :new
        end
      end
    end
  end
#===============================================================================
#    PUT /trips/id:
#===============================================================================
  describe "PUT update" do
    context "when logged in" do
      it "redirect to root" do
        @user = create(:user)
        sign_in @user
        put :update, params: { id: @theme }
        expect(response).to redirect_to '/'
      end
    end
    context "when logged out" do
      it "redirect to root" do
        put :update, params: { id: @theme }
        expect(response).to redirect_to '/'
      end
    end
    context "when admin logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      context "with valid params" do
        it "update theme record" do
          put :update, params: { id: @theme, theme: {name: 'new_theme_name'} }
          expect(@theme.reload.name).to eq 'new_theme_name'
        end
        it "redirect to the new theme" do
          expect(
          put :update, params: { id: @theme, theme: {name: 'new_theme_name'} }
          ).to redirect_to @theme
        end
      end
      context "with invalid params" do
        it "do NOT update theme" do
          expect{
            put :update, params: { id: @theme, theme: {name: nil} }
          }.to_not change(@theme, :name)
        end
        it "render the new view" do
          expect(
            put :update, params: { id: @theme, theme: {name: nil} }
          ).to render_template :edit
        end
      end
    end
  end
#===============================================================================
#    DELETE /trips/:id
#===============================================================================
  describe "DELETE destroy" do
    context "when logged in" do
      it "redirect to root" do
        @user = create(:user)
        sign_in @user
        delete :destroy, params: { id: @theme }
        expect(response).to redirect_to '/'
      end
      it "do NOT delete record" do
        @user = create(:user)
        sign_in @user
        expect{ delete :destroy, params: { id: @theme } }.to_not change(Theme, :count)
      end
    end
    context "when logged out" do
      it "redirect to root" do
        @user = create(:user)
        sign_in @user
        delete :destroy, params: { id: @theme }
        expect(response).to redirect_to '/'
      end
      it "do NOT delete record" do
        @user = create(:user)
        sign_in @user
        expect{ delete :destroy, params: { id: @theme } }.to_not change(Theme, :count)
      end
    end
    context "when admin is logged in" do
      before :each do
        @admin = create(:user, admin: true)
        sign_in @admin
      end
      context "with valid params" do
        it "assign @theme" do
          delete :destroy, params: { id: @theme }
          expect(assigns :theme).to eq @theme
        end
        it "delete theme" do
          expect{ delete :destroy, params: { id: @theme } }.to change(Theme, :count).by(-1)
        end
        it "redirect to Admin control" do
          expect(delete :destroy, params: { id: @theme }).to redirect_to '/setup'
        end
      end
    end
  end
end
