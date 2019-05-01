Feature: Login
Verify login feature against valid and invalid credentials.

Background: Settings for test
Given I am on Login Page

@selenium
Scenario: Login with valid credentials
Verify login feature with valid credentials
When I login with "test_user" and "a"
Then I should see "welcome user" text

@javascript
Scenario: Login with invalid credentials
Verify login feature with invalid credentials
When I login with "test_user" and "abcd"
Then I should see login error message

Scenario: Login with valid credentials Failed
Verify login feature with valid credentials
When I login with "test_user" and "a"
Then I should see "welcome test_user" text