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

When(/^I select the category "(.*?)"$/) do |category_name|
  click_link category_name
end

Then(/^I should see the product "(.*?)"$/) do |product_name|
  page.should have_content product_name
end
