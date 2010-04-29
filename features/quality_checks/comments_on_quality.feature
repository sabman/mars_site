Feature: 
  As a scientist
  I want to be able to comment on data quality
  In order to ensure the data is correct

  Scenario: create a comment about data quality
    Given I am on sample page
    When I select "yes" for "Is this comment about quality?"
    And I press submit
    Then I should see a new comment who's issue is about quality
