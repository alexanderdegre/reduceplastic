#encoding: utf-8
require "spec_helper"

describe Category do
  context "with validations" do
    it "name should be unique" do
      FactoryGirl.create(:category, name: 'Getränke')
      
      same_name_category = FactoryGirl.build(:category, name: 'Getränke')
      
      expect(same_name_category.errors_on(:name)).to include("has already been taken")
    end
  end
  
  context "with url creation" do
    it "url should be numbered with same url" do
      FactoryGirl.create(:category, name: 'Getränke')
      
      second_category = FactoryGirl.create(:category, name: 'Getranke')
      
      second_category.url.should eq("getranke-1")
    end
  end
end
