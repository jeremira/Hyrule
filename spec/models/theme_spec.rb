require 'rails_helper'

describe Theme  do

    before :each do
      @theme = build(:theme)
    end

    it "has a valid factory" do
      expect(@theme).to be_valid
    end

    it "has a name" do
      @theme.name = nil
      expect(@theme).to_not be_valid
    end
    it "has a unique name" do
      @theme.name = 'Babar'
      @theme.save
      @theme2 = build(:theme)
      @theme2.name = 'Babar'
      @theme2.save
      expect(@theme2).to_not be_valid
    end
    it "has a description" do
      @theme.descr = nil
      expect(@theme).to_not be_valid
    end
    it "has a main image" do
      @theme.image = nil
      expect(@theme).to_not be_valid
    end
    it "has a style value" do
      @theme.style = nil
      expect(@theme).to_not be_valid
    end
    it "has a gallery list" do
      @theme.gallery = nil
      expect(@theme).to_not be_valid
    end

end
