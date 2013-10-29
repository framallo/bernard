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



end
