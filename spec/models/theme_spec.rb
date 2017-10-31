require 'rails_helper'

describe Theme  do

    before :each do
      @theme = build(:theme)
    end

    it "has a valid factory" do
      expect(@theme).to be_valid
    end
end
