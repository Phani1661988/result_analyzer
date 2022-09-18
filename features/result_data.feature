Feature: Results Data

Scenario: Load Results Data
	Given Receive result data from MSM
	Then  Count of records should be greater than zero