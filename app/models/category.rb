class Category < ActiveRecord::Base
  attr_accessible :name
  
  acts_as_url :name
  def to_param
    url # or whatever you set :url_attribute to
  end
  
  has_and_belongs_to_many :products
  
end
