require 'spec_helper'

feature 'Checking Reports' do
  let!(:transaction1) {create(:transaction, 
                              amount: 300,  date: "20131005", payee_id: 2, 
                              category_id: 1, pm_type: 1)}
  let!(:transaction2) {create(:transaction, 
                              amount: 350,  date: "20131015", payee_id: 1, 
                              category_id: 2, pm_type: 1)}
  let!(:transaction3) {create(:transaction, 
                              amount: 100,  date: "20131025", payee_id: 3, 
                              category_id: 2, pm_type: 1)}
  let!(:transaction4) {create(:transaction, 
                              amount: -250, date: "20131016", payee_id: 2, 
                              category_id: 3, pm_type: 2)}
  let!(:transaction5) {create(:transaction, 
                              amount: 450,  date: "20131021", payee_id: 3, 
                              category_id: 1, pm_type: 2)}
  
  scenario 'Income vs Expense' do
    visit report_path
    click_link "Income vs Expense"
    page.should have_content('Income vs Expense Report')
    page.has_selector?('.table-bordered').should be_true
    page.should have_content("1")
    page.should have_content("2")
    page.should have_content("750")
    page.should have_content("200")
  end

  scenario 'Spending by payee' do
    visit report_path
    click_link "Spending by Payee"
    page.should have_content('Spending by Payee Report')
    page.has_selector?('.table-bordered').should be_true
    page.should have_content("1")
    page.should have_content("2")
    page.should have_content("3")
    page.should have_content("350")
    page.should have_content("50")
    page.should have_content("550")
  end

  scenario 'Net Worth' do
    visit report_path
    click_link "Net Worth"
    page.should have_content('Net Worth Report')
    page.has_selector?('.table-bordered').should be_true
    page.should have_content("10")
    page.should have_content("950")
  end
  
  scenario "Spending by Category" do
    visit report_path
    click_link "Spending by Category"
    page.should have_content("Spending by Category Report")
    page.has_selector?('.table-bordered').should be_true
    page.should have_content("1")
    page.should have_content("750")
    page.should have_content("2")
    page.should have_content("450")
    page.should have_content("3")
    page.should have_content("-250")
  end

end
