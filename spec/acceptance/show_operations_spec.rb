require_relative 'acceptance_helper'

feature 'Show operations by Companies', %q{
I want to be able to see all operations grouped by Companies} do

  given!(:company_one) { create(:company) }
  given!(:company_two) { create(:company) }
  given!(:operation_one) { create(:operation, company_id: company_one.id, status: 'accepted') }
  given!(:operation_two) { create(:operation, company_id: company_two.id) }


  before do
    visit companies_path
  end

  scenario 'user can get list all operations all grouped by Companies ', js: true do
    click_on 'Get Operations'

    within "#company_#{company_one.id}" do
      expect(page).to have_content company_one.name
      expect(page).to have_content company_one.operations_numbers
      expect(page).to have_content company_one.average_amount
      expect(page).to have_content company_one.accepted_operations_num
      expect(page).to have_content company_one.highest_month_operations
    end

    within "#operation_#{operation_one.id}" do
      expect(page).to have_content operation_one.invoice_num
      expect(page).to have_content operation_one.operation_date
      expect(page).to have_content operation_one.amount
      expect(page).to have_content operation_one.reporter
      expect(page).to have_content operation_one.status

    end

    within "#company_#{company_two.id}" do
      expect(page).to have_content company_two.name
      expect(page).to have_content company_two.operations_numbers
      expect(page).to have_content company_two.average_amount
      expect(page).to have_content company_two.accepted_operations_num
      expect(page).to have_content company_two.highest_month_operations
    end

    within "#operation_#{operation_two.id}" do
      expect(page).to have_content operation_two.invoice_num
      expect(page).to have_content operation_two.operation_date
      expect(page).to have_content operation_two.amount
      expect(page).to have_content operation_two.reporter
      expect(page).to have_content operation_two.status
    end
  end
end

