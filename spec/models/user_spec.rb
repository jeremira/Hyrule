require 'rails_helper'

describe User  do

    before :each do
      @user    = FactoryGirl.create(:user)
      @account = FactoryGirl.create(:account, user: @user)
    end

    it "has a valid factory" do
      expect(@user).to be_valid
    end

    it "has an email" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "is not an admin" do
      expect(@user.admin).to be false
    end

    it "can be set as an admin" do
      @user.admin = true
      expect(@user.admin).to be true
    end

    describe "when deleting an user" do
      it "deletes his hild account" do
        expect{@user.destroy}.to change { Account.count }.by(-1)
      end
    end
end
