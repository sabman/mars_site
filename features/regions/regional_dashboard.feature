Feature: each region has a dashboard
  In order to get an operational picture of my region
  As a scientist working on a region
  I want to get a summary of all avaiable datasets in a region

  Background: I am on a regions page

  Scenario: grain size data 
    Then I should see grain size data
    And I should see regions created by me
    And I should see watch list
