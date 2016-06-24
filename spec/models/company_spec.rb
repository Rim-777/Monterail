require 'rails_helper'
require 'csv'

RSpec.describe Company, type: :model do
  it { should have_many(:operations) }
  it { should validate_presence_of :name }

  let!(:company) { create(:company) }
  let!(:other_company) { create(:company) }
  let!(:operations) { create_list(:operation, 3, company_id: company.id, amount: 100000, status: 'accepted') }
  let!(:other_operations) { create_list(:operation, 2, amount: 100000, company_id: other_company.id) }
  let!(:highest_operation) { create(:operation, company_id: other_company.id, amount: 2000000, operation_date: Date.today.beginning_of_month) }

  describe '#operations_numbers' do
    it 'return number of operations of Company' do
      expect(company.operations_number).to eq 3
    end
  end

  describe '#average_amount' do
    it 'return average amount of operations of Company' do
      expect(company.average_amount).to eq 100000
    end
  end

  describe '#accepted_operations_num' do
    it 'return number accepted operations of Company' do
      expect(company.accepted_operations_num).to eq 3
    end
  end

  describe '#highest_month_operations' do
    it 'return highest month operation of Company during current month ' do
      expect(other_company.highest_month_operations).to eq 2000000
    end
  end

  describe '#create_operations_csv(file)' do
    it 'should receive :open for CSV class' do
      file = Tempfile.new(["operations", '.csv'])
      expect(CSV).to receive(:open).with(file.path, "wb")
      company.create_operations_csv(file)
    end
  end
end
