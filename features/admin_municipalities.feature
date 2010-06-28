Feature: Manage municipalities
    In order to modify municipalities where problems will be reported
    As a site administrator
    I want to manage municipalities

    Scenario: Manage municipalities
        Given I am authenticated as admin
            And I am on the admin page
            And there are no municipalities
            And there is region
        When I follow "Municipalities"
        Then I should see "No municipalities have been added yet"
        When I follow "New Municipality"
            And I fill in "Name" with "Municipality name"
            And I select "Skopski" from "Region"
            And I press "Create"
        Then I should see "Municipality was successfully created"
            And I should see "Municipality name"
        When I follow "Edit"
          And I fill in "Name" with "Municipality name 2"
          And I press "Update"
        Then I should see "Municipality was successfully updated"
            And I should see "Municipality name 2"
