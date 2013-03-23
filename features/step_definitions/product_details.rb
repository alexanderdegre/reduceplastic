Given(/^the following products exist:$/) do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |row|
    product = FactoryGirl.create(:product, name: row['name'], description: row['description'])
    row['categories'].split(',').each do |category_name|
      category = FactoryGirl.create(:category, name: category_name)
      product.categories << category  
    end
  end
end

When(/^I am on the products details page for product "(.*?)"$/) do |product_name|
  product = Product.find_by_name product_name
  visit(product_url(product))
end

Then(/^I should see the product description "(.*?)"$/) do |product_description|
  page.should have_content product_description
end

Then(/^I should see the product categories:$/) do |categories|
  # table is a Cucumber::Ast::Table
  categories.hashes.each do |row|
    find('.categories').should have_content(row['name'])
  end
end
