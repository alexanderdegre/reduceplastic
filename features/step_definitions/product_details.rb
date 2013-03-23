Given(/^the following products exist:$/) do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    product = FactoryGirl.create(:product, name: row['name'], description: row['description'])
  end
end

When(/^I am on the products details page for product "(.*?)"$/) do |product_name|
  product = Product.find_by_name product_name
  visit(product_url(product))
end

Then(/^I should see the product description "(.*?)"$/) do |product_description|
  page.should have_content product_description
end