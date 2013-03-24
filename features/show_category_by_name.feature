Feature: browse categories

	As a portal user 
	I want to get a bookmarkable url for a category (with category name)	

Scenario Outline: url checks for category
	When I select the url "<url>" (category "<category_name>")
	Then I should see the category page for "<category_name>"
	Examples:
		| category_name		 	| url 					|
  		| simple with blanks 	| simple-with-blanks 	| 
  		| Getränke  		 	| getranke				|
  		| I love unicode 你		| i-love-unicode-ni		|