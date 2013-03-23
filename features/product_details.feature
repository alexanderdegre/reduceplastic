Feature: product details

	As a portal user 
	I want to get information about specific products
	so that I can make better purchase decisions

Background:
	Given the following products exist:
  		| name 				| description							 		 | categories 		   |
  		| Lemon Lotion  	| smells like lemon but does taste like lemon ;) | bath,lotions,fruity |
  		| Green Tea  		| this tea wasn't green when it was made 		 | 			  		   |

Scenario: show product description
	Given I am on the products details page for product "Lemon Lotion"
	Then I should see the product description "smells like lemon but does taste like lemon ;)"
	
Scenario: show product categories
	Given I am on the products details page for product "Lemon Lotion"
	Then I should see the product categories:
		| name 	  |
		| bath 	  |
		| lotions |
		| fruity  |
		
Scenario: follow category link
	Given I am on the products details page for product "Lemon Lotion"
	When I click on the category "bath"
	Then I should be on the category page for "bath"