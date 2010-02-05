Feature: Storing GAMS (GA Marine Survey) in MARS
  In order to produce highest quality scientific advice
  As a scientist
  I want to be able to find data related to my Marine Survey from GADA (Geospatial Analysis and Data Acess) project 

  Scenario: GAMS exists in comments as GAMS=XXXX;
    Given a survey exists
    When I go to the survey page
    Then I should see a link to the GADA Data
    And I should see a link to the GADA Metadata
    

