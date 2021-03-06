@vcr @disable_twitter
Feature: Upcoming Events
As a site user
  So that I can find events to join
  I want to see upcoming events
  And I want to see live events
  And I want to see events that are within the scheduled event duration

  Background:
    Given following events exist:
      | name       | description             | category        | start_datetime          | duration | repeats | time_zone |
      | Standup    | Daily standup meeting   | Scrum           | 2014/02/03 07:00:00 UTC | 150      | never   | UTC       |
      | PP Session | Pair programming on WSO | PairProgramming | 2014/02/07 10:00:00 UTC | 15       | never   | UTC       |
      | 25 Min     | Started 20 minutes ago  | PairProgramming | 2014/02/01 08:55:00 UTC | 25       | never   | UTC       |
      | 6 Min      | Started 10 minutes ago  | PairProgramming | 2014/02/01 09:05:00 UTC | 6        | never   | UTC       |
      | Still Live | Started 20 minutes ago  | PairProgramming | 2014/02/01 08:55:00 UTC | 1        | never   | UTC       |

    Given the date is "2014/02/01 09:15:00 UTC"

  Scenario: Show upcoming events
    Given I am on Events index page
    Then I should see "AgileVentures Events"
    And I should see "Standup"
    And I should see "PP Session"

  Scenario: Shows started event within scheduled event duration
    Given I am on Events index page
    And I should see "25 Min"

  Scenario: Show event calendar download link
    Given I am on Events index page
    Then  I should see a link "calendar" to "/calendar"

  Scenario: Show event calendar download link
    Given I am on Events index page
    When I click the "calendar" link
    Then I should receive a file "AgileVentures_events.ics"

  Scenario: Doesn't show event past scheduled event duration
    Given I am on Events index page
    And I should not see "6 Min"

  Scenario: Shows event past end time when still live
    Given an event "Still Live"
    And the "Still Live" host has started the event
    Then the event should be live
    Given I am on Events index page
    Then I should see "Still Live"
