#encoding: utf-8
require "spec_helper"

describe Shop do
  context "when geocoding" do
    it "it succeeds with correct address" do
      shop = FactoryGirl.create(:shop_valid_address)
      
      maxDelta = 0.0001
      shop.longitude.should be_within(maxDelta).of(8.76603)
      shop.latitude.should be_within(maxDelta).of(50.10323)
    end 
  end
  
  context "when creating address proposal/search (ajax)" do
    pending
    #TODO get address search proposals via: Shop.search_address("input") 
  end
  
  context "when validates" do
    field_name_minlength_map = {:name => 2, :postalcode => 5, :street => 2, :city => 2}
        
    describe "with field minlength" do
      field_name_minlength_map.each do |field, min_length|
        sample_value = string_with_length(min_length-1)
        
        it "shows error for #{field} (minlength #{min_length}) with value: #{sample_value}" do
          shop = FactoryGirl.build(:shop, field => sample_value)
      
          expect(shop.errors_on(field)).to include(start_with("is too short"))      
        end
      end
    end
    
    describe "with required field" do
      field_name_minlength_map.each do |field, min_length|
        it "shows error for #{field}" do
          shop = FactoryGirl.build(:shop, field => nil)
        
          expect(shop.errors_on(field)).to include("can't be blank")          
        end 
      end
    end
    
    describe "with address geocoding" do
      #sample url: http://maps.googleapis.com/maps/api/geocode/json?address=Hauptstrasse%20100,%20Frankfurt&sensor=false
      
      before :each do
          #ensure that "address_not_found" will be called now
          Shop.class_eval 'def has_essential_validation_errors?; false; end'
      end
      
      describe "shows error for" do      
        it "no precise match" do
          shop = FactoryGirl.build(:shop, street: 'Wil 5', city: 'Ofen')
          
          expect(shop.errors_on(:geocoding)).to include("not found")    
        end
        
        it "too many matches" do
          shop = FactoryGirl.build(:shop_address_street_only)
          
          expect(shop.errors_on(:geocoding)).to include("different results found")    
        end 
        
        it "partial matches only" do
          shop = FactoryGirl.build(:shop_wrong_address)
          
          expect(shop.errors_on(:geocoding)).to include("not found") 
        end
      end
      
      it "has no error for precise match" do
        shop = FactoryGirl.build(:shop_valid_address)
        
        expect(shop.errors_on(:geocoding)).to be_empty
      end
      
      it "corrects address typos with precise match" do
        shop = FactoryGirl.build(:shop_address_with_typos)
        
        expect(shop.errors_on(:geocoding)).to be_empty
        
        shop.street.should eq("Linsenberg 5")
        shop.city.should eq("Offenbach")
      end
    end
  end
end