Feature:
  Features related to enquiry record, including view enquiry record, create enquiry record

  Background:
    Given the following forms exist in the system:
      | name      |
      | Enquiries |
      | Children  |
    And the following form sections exist in the system on the "Enquiries" form:
      | name             | unique_id        | editable | order | visible | perm_enabled |
      | Enquiry Criteria | enquiry_criteria | false    | 1     | true    | true         |
    And the following fields exists on "enquiry_criteria":
      | name          | type       | display_name  | editable |
      | enquirer_name | text_field | Enquirer Name | false    |
      | child_name    | text_field | Child's Name  | false    |
      | location      | text_field | Location      | false    |

  Scenario: Adding/Viewing Enquiry Record
    Given I am logged in as a user with "Create Enquiry,View Enquiries" permissions
    When I follow "Register New Enquiry"
    And I fill in "Enquirer Name" with "Charles"
    And I fill in "Child's Name" with "Jorge Just"
    And I fill in "Location" with "Kampala"
    And I press "Save"

    Then I should see "Charles"
    And I should see "Jorge Just"
    And I should see "Kampala"

  Scenario: Enquiries link should link to Enquiries list page
    Given I am logged in as a user with "Create Enquiry,View Enquiries" permissions
    When I follow "ENQUIRIES"
    Then I should be on "enquiries listing page"

  @javascript
  Scenario: Enquiries listing page should show enquiries
    Given I am logged in as an admin
    And I follow "System Settings"
    And I follow "Highlight Fields"
    And I follow "Enquiries"
    And I click text "add"
    And I select menu "Enquiry Criteria"
    And I select menu "Enquirer Name"
    Then I logout
    And I am logged in as a user with "Create Enquiry,View Enquiries" permissions
    And the following enquiries exist in the system:
      | enquirer_name | child_name | location |
      | bob           | bob chulu  | kampala  |
      | john          | john doe   | gulu     |
      | jane          | jane doe   | adjumani |
    And I am on the "enquiries listing page"
    Then I should see "bob"
    And I should see "john"
    And I should see "jane"
