Feature: product details

	As a portal user 
	I want to get information about specific products
	so that I can make better purchase decisions

Background:
	Given the following products exist:
  		| name 				| description							 		 |
  		| Lemon Lotion  	| smells like lemon but does taste like lemon ;) | 
  		| Green Tea  		| this tea wasn't green when it was made 		 | 

Scenario: show product details
	When I am on the products details page for product "Lemon Lotion"
	Then I should see the product description "smells like lemon but does taste like lemon ;)"