Feature: Allow login via authentication against the GA LDAP server
  In order to allow personalized content to be create
  As a user of MARS database 
  I want be able to login using my GA account

  Scenario: Successful login
    Given I am a GA user
    And I am on login page
    When  I fill in my username and password
    And I press "Login"
    Then I should see "Successfully logged in."
    And I should see "Logout"

#  Scenario: Log out
#    Given I am logged in
#    And I am on the homepage
#    When I follow "logout"
#    Then I should see "Logout successful!"
#    And I should see "Register"
#    And I should see "Log In"

# TODO: rename this file ldap_user_authentication.rb
