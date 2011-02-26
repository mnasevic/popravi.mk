Feature: Admin can manage posts
  In order to publish posts on blog
  As a site administrator
  I want to be able to manage posts

  Scenario: Admin can manage posts
    Given I am authenticated as admin
    When I follow "Posts"
    And I follow "New"
    And I check "Custom slug"
    And I fill in "Slug" with "my-custom-slug"
    And I fill in "Title" with "Hello world"
    And I fill in "Content" with "Post content"
    And I check "Publish"
    And I press "Save"
    Then I should see "Post was successfully created"
    And I should see "Test User"
    And I should see "Hello world"
    When I follow "Hello world"
    Then I should see "my-custom-slug"
    When I follow "Edit"
    And I fill in "Content" with "Post content 2"
    And I press "Save"
    Then I should see "Post was successfully updated"
    When I follow "Hello world"
    And I should see "hello-world"
    Then I should see "Hello world"
    And I should see "Post content 2"
