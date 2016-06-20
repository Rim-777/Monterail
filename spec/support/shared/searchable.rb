shared_examples_for 'Searchable' do
  scenario "user can get list all operations filtered by", js: true do
    select('Operation', from: 'category')
    fill_in 'query', with: filter
    click_on 'Get Operations'

    within "#company_#{company_one.id}_operations_table" do
      expect(page).to have_content operation_one.invoice_num
      expect(page).to have_content operation_one.operation_date
      expect(page).to have_content operation_one.amount
      expect(page).to have_content operation_one.reporter
      expect(page).to have_content operation_one.status
      expect(page).to have_content operation_one.kind
    end

    expect(page).to_not have_content operation_two.invoice_num
    expect(page).to_not have_content operation_two.amount
    expect(page).to_not have_content operation_two.reporter
    expect(page).to_not have_content operation_two.status
    expect(page).to_not have_content operation_two.kind
  end
end
