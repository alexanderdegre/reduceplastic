class AddIndexToShopLongitudeAndLatitude < ActiveRecord::Migration
  def change
    add_index :shops, [:latitude, :longitude]
  end
end
