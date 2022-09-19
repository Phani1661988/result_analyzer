Feature: Monthly Results Data

Scenario: Load Monthly Results Data
	Given Calculate Monthly Results Data
	Then  Monthly count of records should be greater than zero