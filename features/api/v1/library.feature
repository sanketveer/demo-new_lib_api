Feature: Library Management

  Scenario: List Books in an library
    Given there is an existing library with ID
    And there are existing books in the library
    When I list books in the library with ID
    Then I should receive the following books:
      | titile   |available | checked_out_by|
      | Tali     | true     |               |