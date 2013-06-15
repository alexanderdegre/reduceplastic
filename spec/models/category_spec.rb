#encoding: utf-8
require "spec_helper"

describe Category do
  context "validates" do
    it "name should be unique" do
      FactoryGirl.create(:category, name: 'Getränke')
      
      same_name_category = FactoryGirl.build(:category, name: 'Getränke')
      
      expect(same_name_category.errors_on(:name)).to include("has already been taken")
    end
  end
  
  context "creates url" do
    it "with numbering if name already exists" do
      FactoryGirl.create(:category, name: 'Getränke')
      
      second_category = FactoryGirl.create(:category, name: 'Getranke')
      
      second_category.url.should eq("getranke-1")
    end
  end
end
