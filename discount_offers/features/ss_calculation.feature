Feature: Calculate each customers' suitability score (SS)

  In order to determine which product to offer a customer
  As a salesperson
  I want to calculate the customer's suitability score

  Scenario: 
    Given customers named
      | Jack Abraham |
      | John Evans   |
      | Ted Dziuba   |
    And products called
      | iPad 2 - 4-pack        |
      | Girl Scouts Thin Mints |
      | Nerf Crossbow          |
    When I run the suitability score calculator
    Then I should see the following suitability scores:
      | 21.00 |
      | 83.50 |
      | 71.25 |
