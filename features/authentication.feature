Feature: Authentication
  In order to keep a journal
  Visitors to the web application
  Should be able to signup, login, and logout

  Scenario: Signup
    Given I go to the signup page
    When I fill in "Bertram" for "Login"
    And I fill in "bertram@example.com" for "Email"
    And I fill in "123456" for "Password"
    And I fill in "123456" for "Confirm Password"
    And I press "Sign up"
    Then I should see "Thanks for signing up!"

  Scenario: Signup (Refactored)
    Given I go to the signup page
    When I fill in the following:
      | Login | Bertram |
      | Email | bertram@example.com |
      | Password | 123456 |
      | Confirm Password | 123456 |
    And I press "Sign up"
    Then I should see "Thanks for signing up!"
    
  Scenario: Login
    Given a valid user
    When I go to the login page
    And I fill in the following:
      |Login|bertram|
      |Password|123456|
    And I press "Log in"
    Then I should see "Logged in successfully"
    