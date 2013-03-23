Feature: browse categories

	As a portal user 
	I want to search for plastic reduced or free products within categories
	so that I can better my health

Background:
	Given the following categories with products exist:
  		| category 			| products 		|
  		| Kosmetik 			| Creme,Shampoo | 
  		| Getränke  		| Tee,Softdrink | 
	And I am on the categories page

Scenario: select category
	When I select the category "Kosmetik"
	Then I should see the product "Creme"
 	And I should see the product "Shampoo"