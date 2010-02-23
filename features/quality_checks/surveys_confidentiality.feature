As a data manager
I want to know confidentiality of Surveys
In order to correct the data

Given I am on the quality_checks page
When I go to /quality_checks/surveys
Then I should see all surveys that are missing metadata fields
