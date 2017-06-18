require 'rails_helper'

describe Rythme  do

    before :each do
      @gestion = FactoryGirl.create(:gestion)
    end

    it "has a valid factory" do
      expect(@gestion).to be_valid
    end
    it "has a status default value : 'contruction'" do
      expect(@gestion.status).to eq 'new'
    end

end
