When(/^I select the url "(.*?)" \(category "(.*?)"\)$/) do |url, category_name|
  FactoryGirl.create(:category, name: category_name)
  visit "/categories/#{url}"
end

Then(/^I should see the category page for "(.*?)"$/) do |category_name|
  page.should have_content category_name
end
