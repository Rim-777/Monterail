require 'rails_helper'
require 'csv'

describe 'import service' do

  describe '#initialize' do
    let!(:file) { Rails.root.join("spec/support/files/test.csv") }
    it 'assign file-content to @file' do
      import = ImportService.new(file)
      expect(import.file).to eq file
    end
  end

  describe '#perform!' do
    let!(:company_one) { create(:company, name: 'CompanyName') }
    let(:import) { ImportService.new(file).perform! }

    describe 'success' do
      let!(:file) { Rails.root.join("spec/support/files/test.csv") }

      context 'operations' do
        before { import }

        it 'change operations number to database' do
          expect(Operation.all.count).to eq 1
        end

        it 'assign company id for new operation' do
          expect(Operation.first.company_id).to eq company_one.id
        end

        it 'assign invoice num for new operation' do
          expect(Operation.first.invoice_num).to eq 'testInvoiceNum'
        end

        it 'assign invoice date for new operation' do
          expect(Operation.first.invoice_date).to eq Date.new(2014, 10, 19)
        end

        it 'assign operation date for new operation' do
          expect(Operation.first.operation_date).to eq Date.new(2014, 10, 11)
        end

        it 'assign amount date for new operation' do
          expect(Operation.first.amount).to eq 18068.43
        end

        it 'assign reporter date for new operation' do
          expect(Operation.first.reporter).to eq 'TestReporter'
        end

        it 'assign notes date for new operation' do
          expect(Operation.first.notes).to eq 'TestNotes'
        end

        it 'assign status date for new operation' do
          expect(Operation.first.status).to eq 'TestStatus'
        end

        it 'assign kind date for new operation' do
          expect(Operation.first.kind).to eq 'category_1;category_2;category_3'
        end
      end

      context 'categories_operation' do
        it 'change categories_operations number in database' do
          expect { import }.to change(CategoriesOperation, :count).by(3)
        end

        it 'add categories_operations for operation' do
          import
          expect(Operation.first.categories_operations.count).to eq 3
        end

        it 'add relation between operation and categories' do
          import
          expect(Operation.first.categories.pluck(:name).sort).to eq %w(Category_1 Category_2 Category_3).sort
        end
      end
    end

    describe 'un-success' do
      let!(:existing_operation_for_unique_invoice_num) { create(:operation, invoice_num: 'UniqueInvoiceNum') }
      let!(:file) { Rails.root.join("spec/support/files/invalid_import_test.csv") }

      it 'will not add new operations in database' do
        expect { import }.to_not change(Operation, :count)
      end

      it 'will not add new categories_operation in database' do
        expect { import }.to_not change(CategoriesOperation, :count)
      end

      it 'will not add new categories in database' do
        expect { import }.to_not change(Category, :count)
      end
    end

    describe 'private methods' do
      import = ImportService.new(Rails.root.join("spec/support/files/test.csv"))

      describe '#find_company' do
        let!(:company_one) { create(:company, name: 'CompanyName') }

        it 'return company id' do
          expect(import.send(:find_company, 'CompanyName')).to eq company_one.id
        end
      end

      describe '#formatted_date' do
        it 'return nil if date invalid' do
          expect(import.send(:formatted_date, Date._parse('32-12-2016'))).to eq nil
        end

        it 'take date in format YYYY-DD-MM and do format YYYY-MM-DD' do
          expect(import.send(:formatted_date, Date._parse('2016-16-3'))).to eq Date.new(2016, 03, 16)
        end

        it 'take date in format YYYY-MM-DD and do format YYYY-MM-DD' do
          expect(import.send(:formatted_date, Date._parse('2016-3-16'))).to eq Date.new(2016, 3, 16)
        end

        it 'take date in format MM-DD-YYYY and do format YYYY-MM-DD' do
          expect(import.send(:formatted_date, Date._parse('3-16-2016'))).to eq Date.new(2016, 3, 16)
        end

        it 'take date in format MM-YYYY-DD and do format YYYY-MM-DD' do
          expect(import.send(:formatted_date, Date._parse('3-2016-16'))).to eq Date.new(2016, 3, 16)
        end

        it 'take date in format DD-MM-YYYY and do format YYYY-MM-DD' do
          expect(import.send(:formatted_date, Date._parse('16-3-2016'))).to eq Date.new(2016, 3, 16)
        end

        it 'take date in format DD-YYYY-MM and do format YYYY-MM-DD' do
          expect(import.send(:formatted_date, Date._parse('16-2016-3'))).to eq Date.new(2016, 3, 16)
        end
      end
    end
  end
end