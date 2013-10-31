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
  end
end
