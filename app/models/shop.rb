class Shop < ActiveRecord::Base
  validates :name, :uniqueness => true
  
  attr_accessible :city, :country, :description, :latitude, :longitude, :name, :postalcode, :state, :street
  
  geocoded_by :full_street_address
  after_validation :geocode
  
  private
  
  def full_street_address
    [street, postalcode, city, state, country].compact.join(', ')
  end
end
