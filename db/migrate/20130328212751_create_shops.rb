class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.string :street
      t.string :city
      t.string :postalcode
      t.string :country
      t.string :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
