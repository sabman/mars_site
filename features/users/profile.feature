Feature: User profiles
  As a user
  In order to have personalised content
  I want to see my profile

  Scenario: Details from LDAP 
  Given I am logged in
  And I go to current user page
  Then I should see my email address
