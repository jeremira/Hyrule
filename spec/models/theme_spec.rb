require 'rails_helper'

describe Theme  do

    before :each do
      @theme = FactoryGirl.create(:theme)
    end

    it "has a valid factory" do
      expect(@theme).to be_valid
    end
    it "is has a name" do
      @theme.name = nil
      expect(@theme).to_not be_valid
    end
    it "is has a description" do
      @theme.descr = nil
      expect(@theme).to_not be_valid
    end
    it "is has an image url" do
      @theme.descr = nil
      expect(@theme).to_not be_valid
    end
    it "has an unique name" do
      @theme_with_same_name = FactoryGirl.build(:theme, name: @theme.name)
      expect(@theme_with_same_name).to_not be_valid
    end
    it "destroy his days child" do
        FactoryGirl.create(:day, theme: @theme)
        expect { @theme.destroy }.to change { Day.count }.by(-1)
    end
end
