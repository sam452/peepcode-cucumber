Feature: Manage journal entries
  As one who shaves
  I want to record the quality of my experience
  So I can improve my skills with a razor

  Background:
    Given a logged in user
  
  Scenario: View the calendar
    When I go to the home page
    Then the calendar should show the current month
    And the page should link to /\/journal_entries\/\d{4}-\d{2}-\d{2}/

  Scenario: View a single page
    When I go to a journal entry page
    Then I should see "Sunday" within "h1"
    And the record should belong to the current user


  Scenario: View a prepopulated entry
    Given an existing journal entry record with the following data:
      | key    | value         |
      | notes  | A close shave |
      | rating | 5             |
      | date   | 2010-10-10    |
    When I go to a journal entry page
    Then the "Notes" field should contain "A close shave"
    And the "5" checkbox should be checked

  Scenario: Enter new information in the form
    Given I go to a journal entry page
    When I fill in "Sharp as the blues" for "Notes"
    And I choose "3"
    And I press "Save"      
    Then the user's journal entry should have the following values:
      | key    | value              | transform |
      | date   | 2010-10-10         | to_date   |
      | notes  | Sharp as the blues | to_s      |
      | rating | 3                  | to_i      |

  Scenario: Get Nicks via API
    Given an existing nick with the following data:
      | key      | value      |
      | date     | 2010-10-10 |
      | position | 100,200    |
    When I go to my list of nicks for "2010-10-10"
    Then I should see JSON output containing nick data '["100","200"]'

      
