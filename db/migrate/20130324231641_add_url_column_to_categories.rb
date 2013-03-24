class AddUrlColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :url, :text  
  end
end
