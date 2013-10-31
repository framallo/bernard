require 'spec_helper'
feature "check total amount per account" do

  before(:each) do
    visit accounts_path
  end

  scenario "cheack all categories" do
    page.should have_content("Efectivo")
    page.should have_content("$550.00")
    page.should have_content("$4,490.00")
    page.should have_content("Tarjeta")
    page.should have_content("-$250")
    page.should have_content("$3,050.00")
    page.should have_content("Cuenta Ahorro")
    page.should have_content("$0.00")
    page.should have_content("$950.00")
  end

  scenario "Check Efectivo" do
    click_link "Efectivo"
    page.should have_content("(17)")
    page.should have_content("$4,490.00")
    page.should have_content("10/16/13")
    page.should have_content("$1,750.00")
    page.should have_content("10/17/13")
    page.should have_content("$640.00")
    page.should have_content("10/18/13")
    page.should have_content("$150.00")
    page.should have_content("10/23/13")
    page.should have_content("$500.00")
    page.should have_content("10/31/13")
    page.should have_content("$1,750.00")
  end

  scenario "Check Tarjeta" do
    click_link "Tarjeta"
    page.should have_content("(11)")
    page.should have_content("$3,050.00")
    page.should have_content("10/07/13")
    page.should have_content("-$2,500.00")
    page.should have_content("10/17/13")
    page.should have_content("$1,250.00")
    page.should have_content("10/18/13")
    page.should have_content("$4,300.00")
  end
  
  scenario "Cuenta Ahorro" do
    click_link "Cuenta Ahorro"
    page.should have_content("(9)")
    page.should have_content("$950.00")
    page.should have_content("10/18/13")
    page.should have_content("$1,450.00")
    page.should have_content("10/23/13")
    page.should have_content("-$500.00")
 end
end
