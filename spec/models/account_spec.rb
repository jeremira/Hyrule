require 'rails_helper'

describe Account  do

    before :each do
      @account = build(:account)
    end

    it "has a valid factory" do
      expect(@account).to be_valid
    end

end
