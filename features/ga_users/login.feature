Feature: LDAP login
  In order to use the shiny new MARS site
  As a GA employee
  I want to be able to use my ORAPROD login/password to authenticate

  Scenario: A user exists and successfully logs in
    Given a user exists with username SBURQ, password password!
    And I am at the login page
    When I enter username and password
    And I submit
    Then I should be logged in
