Feature: regions of interest to the group
  In order to find MARS data for my region of interest
  As a GA employee using MARS data for great geoscientific research
  I want to be able to maintain a set of regions

  Scenario: User is not logged in
    Given I am not logged in
    When I go to the regions page
    Then I should see a list of regions




