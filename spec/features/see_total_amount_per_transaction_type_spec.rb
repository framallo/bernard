require 'spec_helper'
feature 'check total amount per transaction type' do

  before(:each) do
    visit root_path
    click_link "This Year"
  end

  scenario "Deposit Transaction" do 
    click_link "Deposit"
    page.should have_content("$12,600.00")
    within('table') do
      page.should have_content("10/16/13")
      page.should have_content("$1,750.00")
      page.should have_content("10/17/13")
      page.should have_content("$2,500.00")
      page.should have_content("10/18/13")
      page.should have_content("$6,600.00")
      page.should have_content("10/31/13")
      page.should have_content("$1,750.00")
    end
  end

  scenario "Transfer Transaction" do 
    click_link "Transfer"
    page.should have_content("$5,000.00")
    within('table') do
      page.should have_content("10/17/13")
      page.should have_content("-$1,250.00")
      page.should have_content("10/18/13")
      page.should have_content("-$3,250.00")
      page.should have_content("10/23/13")
      page.should have_content("-$500.00")
    end
  end

  scenario "Widthdrawals Transaction" do 
    click_link "Widthdrawals"     
    page.should have_content("$4,110.00")
    within('table') do
      page.should have_content("10/07/13")
      page.should have_content("-$2,500.00")
      page.should have_content("10/17/13")
      page.should have_content("-$610.00")
      page.should have_content("10/18/13")
      page.should have_content("-$1,000.00")
    end
  end

end
