Feature: browse products

	As a portal user 
	I want to browse for plastic reduced or free products
	so that I can save my health

Background:
	Given the following categories with products exist:
  		| category 			| products 		|
  		| Kosmetik 			| Creme,Shampoo | 
  		| Getränke  		| Tee,Softdrink | 
	And I am on the products page

Scenario: by category

	Given I select the category "Kosmetik"
	Then I should see the product "Creme"
 	And I should see the product "Shampoo"