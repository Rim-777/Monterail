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

  describe '#add_categories!' do
    let(:described_method) { operation.add_categories! }

    context 'new category' do
      let!(:operation) { create(:operation, kind: 'new_category;') }

      it 'creates a new category in the database' do
        expect { described_method }.to change(Category, :count).by(1)
      end

      it 'create a new category in  the database for the operation' do
        expect { described_method }.to change(operation.categories, :count).by(1)
      end

      it 'changes an operation number for the category' do
        described_method
        expect(Category.first.operations.size).to eq 1
      end

      it_behaves_like 'Categoriable'

      it "capitalizes category name" do
        described_method
        expect(operation.categories.first.name).to eq "New_category"
      end
    end

    context 'existing category' do
      let!(:existing_category) { create(:category, name: 'Existing_category') }
      let!(:operation) { create(:operation, kind: 'existing_category') }

      it 'will not create new category in database' do
        expect { described_method }.to_not change(Category, :count)
      end

      it 'changes an operation number for the category' do
        expect(Category.first.operations.size).to eq 0
        described_method
        expect(Category.first.operations.size).to eq 1
      end

      it_behaves_like 'Categoriable'
    end

    context 'duplicates of categories' do
      context 'existing_category' do
        let!(:existing_category) { create(:category, name: 'Existing_category') }
        let!(:operation) { create(:operation, kind: 'Existing_category;Existing_category;existing_category') }

        it 'will not create new category in database' do
          expect { described_method }.to_not change(Category, :count)
        end

        it 'creates only one categories_operation in the database' do
          expect { described_method }.to change(CategoriesOperation, :count).by(1)
        end
      end

      context 'new_category' do
        let!(:operation) { create(:operation, kind: 'new_category;New_category;new_category') }

        it 'creates only one new category in the database' do
          expect { described_method }.to change(Category, :count).by(1)
        end

        it 'creates only one categories_operation in the database' do
          expect { described_method }.to change(CategoriesOperation, :count).by(1)
        end
      end
    end
  end
end
