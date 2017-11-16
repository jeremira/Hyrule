require 'rails_helper'

describe UsersController  do
  before :each do
    @user = create(:user)
  end
#===============================================================================
#   GET /trip/:id
#===============================================================================
  describe "GET show" do
    context "when logged in" do
      before :each do
        sign_in @user
      end
      it "respond successfully" do
        expect( get :show, params: { id: @user } ).to be_success
      end
      it "assign @user" do
        get :show, params: { id: @user }
        expect(assigns :user).to eq @user
      end
      it "find and assign @account" do
        @account = create(:account, user: @user)
        get :show, params: { id: @user }
        expect(assigns :account).to eq @account
      end
      it "create and assign @account" do
        get :show, params: { id: @user }
        expect(assigns :account).to be_a_new Account
      end
    end
    context "when not logged in" do
      it "redirect to root page" do
        expect( get :show, params: { id: @user } ).to redirect_to '/users/sign_in'
      end
    end
  end
#===============================================================================
#   GET trips/:id/edit
#===============================================================================
  describe "GET edit" do
    context "when logged in" do
      before :each do
        sign_in @user
      end
      it "respond successfully" do
        expect( get :edit, params: { id: @user } ).to be_success
      end
      it "assign @user" do
        get :show, params: { id: @user }
        expect(assigns :user).to eq @user
      end
      it "find and assign @account" do
        @account = create(:account, user: @user)
        get :show, params: { id: @user }
        expect(assigns :account).to eq @account
      end
      it "create and assign @account" do
        get :show, params: { id: @user }
        expect(assigns :account).to be_a_new Account
      end
    end
    context "when not logged in" do
      it "redirect to root page" do
        expect( get :show, params: { id: @user } ).to redirect_to '/users/sign_in'
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
      it "assign @user" do
        put :update, params: { id: @user, user: { email: 'new_email@aol.com'} }
        expect(assigns :user).to eq @user
      end
      context "with valid params" do
        it "update user" do
          put :update, params: { id: @user, user: { email: 'new_email@aol.com'} }
          expect(@user.reload.email).to eq 'new_email@aol.com'
        end
        it "redirect to user profile" do
          put :update, params: { id: @user, user: { email: 'new_email@aol.com'} }
          expect(response).to redirect_to @user
        end
      end
      context "with invalid params" do
        it "do NOT update user" do
          @account = create(:account, user: @user)
          old_email = @user.email
          put :update, params: { id: @user, user: { email: nil } }
          expect(@user.reload.email).to eq old_email
        end
        it "render edit template" do
          @account = create(:account, user: @user)
          expect(
            put :update, params: { id: @user, user: { email: nil } }
          ).to render_template :edit
        end
      end
    end
    context "when user is logged out" do
      it "redirect to root page" do
        put :update, params: { id: @user, user: { email: 'barbapapa@lycos.fr' } }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end
end
