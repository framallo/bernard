require 'spec_helper'
feature 'check total amount per category' do

  scenario 'Per category' do 
    visit root_path
    click_link "This Year"
    page.should have_content('Salario')
    page.should have_content('$3,500.00')
    page.should have_content('Personal')
    page.should have_content('$8,900.00')
    page.should have_content("Automóvil")
    page.should have_content('-$200.00')
    page.should have_content('Entretenimiento')
    page.should have_content('$0.00')
  end

  scenario "Salario Category" do 
    visit root_path
    click_link "This Year"
    click_link "Salario"
    page.should have_content("10/16/13")
    page.should have_content("10/31/13")
    page.should have_content("$1,750.00")
    page.should have_content("Deposit")
    page.should have_content("$3,500.00")
  end

  scenario "Personal Category" do 
    visit root_path
    click_link "This Year"
    click_link "Personal"
    page.should have_content("10/18/13")
    page.should have_content("$6,500.00")
    page.should have_content("10/17/13")
    page.should have_content("$2,400.00")
    page.should have_content("Deposit")
    page.should have_content("$9,000.00")
    page.should have_content("Widthdrawals")
    page.should have_content("$100.00")
  end

  scenario "Automovil Category" do 
    visit root_path
    click_link "This Year"
    click_link "Automóvil"
    page.should have_content("10/17/13")
    page.should have_content("-$200.00")
   page.should have_content("Widthdrawals")
    page.should have_content("$200.00")
  end

  scenario "Caridad Category" do 
    visit root_path
    click_link "This Year"
    click_link "Caridad"
    page.should have_content("10/18/13")
    page.should have_content("-$1,000.00")
    page.should have_content("Transfer")
    page.should have_content("$1,800.00")
    page.should have_content("Widthdrawals")
    page.should have_content("$1,000.00")
  end
end
