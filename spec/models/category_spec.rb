#encoding: utf-8
require "spec_helper"

describe Category do
  context "when validates" do
    it "shows error if name not unique" do
      FactoryGirl.create(:category, name: 'Getränke')
      
      same_name_category = FactoryGirl.build(:category, name: 'Getränke')
      
      expect(same_name_category.errors_on(:name)).to include("has already been taken")
    end
  end
  
  context "when creating url" do
    it "adds number to url part if name already exists" do
      FactoryGirl.create(:category, name: 'Getränke')
      
      second_category = FactoryGirl.create(:category, name: 'Getranke')
      
      second_category.url.should eq("getranke-1")
    end
  end
end
