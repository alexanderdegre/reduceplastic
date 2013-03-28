#encoding: utf-8
require "spec_helper"

describe Shop do
  context "with geocoding" do
    it "sample successful geocoding" do
      shop = FactoryGirl.create(:shop, street: 'Wilhelmsplatz 5', city: 'Offenbach')
      
      maxDelta = 0.0001
      shop.longitude.should be_within(maxDelta).of(8.76603)
      shop.latitude.should be_within(maxDelta).of(50.10323)
    end 
  end
end
