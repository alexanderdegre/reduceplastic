class AddUqToCategoryUrl < ActiveRecord::Migration
  def change
    add_index :categories, :url, :unique => true
  end
end
