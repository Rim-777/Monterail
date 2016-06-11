require 'rails_helper'

RSpec.describe Operation, type: :model do
  it { should have_many(:categories_operations).dependent(:destroy) }
  it { should have_many(:categories).through(:categories_operations) }
  it { should belong_to(:company) }
  it { should validate_presence_of(:company_id) }
  it { should validate_presence_of(:invoice_num) }
  it { should validate_presence_of(:invoice_date) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:operation_date) }
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:status) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }

  describe "invoice_num uniqueness validations" do
    subject { create(:operation) }
    it { should validate_uniqueness_of(:invoice_num) }
  end
end
