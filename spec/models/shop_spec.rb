#encoding: utf-8
require "spec_helper"

describe Shop do
  context "with geocoding" do
    it "sample successful geocoding" do
      shop = FactoryGirl.create(:shop_valid_address)
      
      maxDelta = 0.0001
      shop.longitude.should be_within(maxDelta).of(8.76603)
      shop.latitude.should be_within(maxDelta).of(50.10323)
    end 
  end
  
  context "with validations" do
    describe "minlength" do
      {:name => 2,:postalcode => 5,:street => 2,:city => 2}.each do |field, min_length|
        sample_value = string_with_length(min_length-1)
        
        it "validate #{field} with minlength #{min_length} (value: #{sample_value})" do
          shop = FactoryGirl.build(:shop, field => sample_value)
      
          expect(shop.errors_on(field)).to include(start_with("is too short"))      
        end
      end
    end
    
    describe "required" do
      [:name, :postalcode, :street, :city].each do |field, min_length|
        it "validate #{field} presence required" do
          shop = FactoryGirl.build(:shop, field => nil)
        
          expect(shop.errors_on(field)).to include("can't be blank")          
        end 
      end
    end
    
    describe "address validations via geocoding" do
      #sample url: http://maps.googleapis.com/maps/api/geocode/json?address=Hauptstrasse%20100,%20Frankfurt&sensor=false
      
      before :each do
          #ensure that "address_not_found" will be called now
          Shop.class_eval 'def has_validation_errors?; false; end'
      end
      
      it "address not precise - no precise result" do
        shop = FactoryGirl.build(:shop, street: 'Wil 5', city: 'Ofen')
        
        expect(shop.errors_on(:geocoding)).to include("not found")    
      end
      
      it "address not precise - multiple precise results" do
        shop = FactoryGirl.build(:shop_address_street_only)
        
        expect(shop.errors_on(:geocoding)).to include("different results found")    
      end
      
      it "correct address found" do
        shop = FactoryGirl.build(:shop_valid_address)
        
        expect(shop.errors_on(:geocoding)).to be_empty
      end 
      
      it "wrong address - partial_match results only" do
        shop = FactoryGirl.build(:shop_wrong_address)
        
        expect(shop.errors_on(:geocoding)).to include("not found") 
      end
    end
  end
end