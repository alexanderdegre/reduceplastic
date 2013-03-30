FactoryGirl.define do
  factory :shop do
    name "test shop"
  end
  
  factory :shop_valid_address, class: Shop do
    name "test shop"
    postalcode "63065"
    street 'Wilhelmsplatz 5'
    city 'Offenbach'
  end
  
  factory :shop_wrong_address, class: Shop do
    name "test shop"
    street 'Hauptstrasse 100'
    postalcode '63065'
    city 'Frankfurt'
  end
  
  factory :shop_address_street_only, class: Shop do
    name "test shop"
    street 'Hauptstrasse 100'
  end
end