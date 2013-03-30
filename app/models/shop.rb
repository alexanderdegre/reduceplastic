class Shop < ActiveRecord::Base
  validates :name, :uniqueness => true
  validates :name, :city, :street, :presence => true, :length => { :minimum => 2 }
  validates :postalcode, :presence => true, :length => { :minimum => 5 }
  validate :address_not_found
  
  attr_accessible :city, :country, :description, :latitude, :longitude, :name, :postalcode, :state, :street
  
  geocoded_by :full_street_address
  
  private
  
  def address_not_found
    #geocoder checks only needed if no essential validation errors found so far
    return if has_validation_errors?
    
    results = Geocoder.search(full_street_address)
    good_precisions = ['ROOFTOP', 'RANGE_INTERPOLATED']
    precise_results = results.map { |r| r if good_precisions.include?(r.precision) and not(r.data["partial_match"]) }.compact
    case 
      when precise_results.size > 1
        errors.add(:geocoding, "different results found") if precise_results.size > 1
      when precise_results.size < 1
        errors.add(:geocoding, "not found") if precise_results.size < 1
      when precise_results.size == 1
        first_result = precise_results[0]
        import_gmap_results(first_result)
          
        self.latitude, self.longitude = first_result.latitude, first_result.longitude
    end
  end
  
  def import_gmap_results(result)
    street_number_array = result.address_components_of_type(:street_number)
    street_number = if street_number_array[0] != nil
      street_number_array[0]["long_name"]
    end 
    street = "#{result.route} #{street_number}"
    
    self.country, self.state, self.postalcode, self.street, self.city = 
          result.country, result.state, result.postal_code, street, result.city
  end
  
  def has_validation_errors? 
    self.errors.size > 0
  end
  
  def full_street_address
    [street, postalcode, city, state, country].compact.join(', ')
  end
end
