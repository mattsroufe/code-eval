Feature: Cash register calculates a customer's change

  In order to determine how much change to give a customer
  As a cashier
  I want the cash register to calculate the customer's change

  Scenario Outline: transaction
    Given an item with a purchase price of <price>
    When a customer pays with <cash>
    Then the cash register should say <change> is due to the customer

    Examples:
      | price  | cash   | change                                                                                            |
      | 15.94  | 16.00  | NICKEL,PENNY                                                                                      |
      | 17     | 16     | ERROR                                                                                             |
      | 35     | 35     | ZERO                                                                                              |
      | 45     | 50     | FIVE                                                                                              |
      | 233.37 | 352.63 | ONE HUNDRED,TEN,FIVE,TWO,TWO,QUARTER,PENNY                                                        |
      | 21     | 93     | FIFTY,TWENTY,TWO                                                                                  |
      | 11.32  | 353.24 | ONE HUNDRED,ONE HUNDRED,ONE HUNDRED,TWENTY,TWENTY,ONE,HALF DOLLAR,QUARTER,DIME,NICKEL,PENNY,PENNY |
      | 22.5   | 45.96  | TWENTY,TWO,ONE,QUARTER,DIME,DIME,PENNY                                                            |
