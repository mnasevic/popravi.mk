# Feature: Visitor can see problem on municipality page
#   In order to see how municipality is working
#   As a visitor
#   I want to be able to see problem on municipality page

#   Scenario: Visitor can see problems on municipality page
#     Given a region exists with name: "region1"
#     And a municipality exists with name: "Municipality1", region: the region
#     And a problem exists with description: "problem1", municipality: the municipality
#     And I am on the home page
#     page.should have_content "Municipality1 1"
#     click_link "View all municipalities"
#     click_link "Municipality1"
#     click_link "Municipality1"
#     page.should have_content "problem1"