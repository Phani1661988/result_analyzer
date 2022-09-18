Feature: Daily Result Stats

Scenario: Calculate Daily Result Stats
	Given Calculate Daily Stat from Results data
	Then  Daily Result Stats should be greater than zero

Scenario: Get Daily Result Stats
   Given  Get Daily Stats