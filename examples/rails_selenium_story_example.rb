require File.expand_path(File.dirname(__FILE__) +  '/../helper')

Story "User creating misc. expense", %|
  As a user 
  I want be able to submit an expense reimbursement request for a misc. expense
  so that I can be reimbursed|,
  :steps_for => [:expense_reimbursements, :a_user_creating_a_misc_expense],
  :type => RailsSeleniumStory do
 
  Scenario "successfully creating a misc. expense" do
    Given "a user at a new expense reimbursement page"
    When "they click the add misc. expense link"
    Then "they will see the new misc. expense form"
    
    When "they submit the misc. expense form with required information"
    Then "they will see newly created misc. expense in the expense's list"
  end
end

