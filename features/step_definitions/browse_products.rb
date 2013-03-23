Given(/^the following categories with products exist:$/) do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    #puts "Kategorie: #{row['category']}, Produkte: #{row['products']}"
    category = FactoryGirl.create(:category, name: row['category'])
    row['products'].split(',').each do |product_name|
      product = FactoryGirl.create(:product, name: product_name)
      product.categories << category  
    end
  end
end

Given(/^I am on the categories page$/) do
  visit "/categories"
end

Given(/^I select the category "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the product "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
