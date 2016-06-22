require 'rails_helper'
require 'csv'

describe 'import service' do
  let!(:file) { Rails.root.join("spec/support/files/test.csv") }
  let(:import) { ImportService.new(file) }

  describe '#initialize' do
    it 'assign file-content to @file' do
      expect(import.file).to eq file
    end
  end

  describe '#perform!' do
    let!(:company_one) { create(:company, name: 'CompanyName') }
    let(:perform!) { import.perform! }

    describe 'success' do
      it 'changes operations number to database' do
        expect { perform! }.to change(Operation, :count).by(1)
      end

      context 'operations' do
        before { perform! }

        it 'assigns company id for a new operation' do
          expect(Operation.first.company_id).to eq company_one.id
        end

        it 'assigns invoice num for a new operation' do
          expect(Operation.first.invoice_num).to eq 'testInvoiceNum'
        end

        it 'assigns invoice date for a new operation' do
          expect(Operation.first.invoice_date).to eq Date.new(2014, 10, 19)
        end

        it 'assign the operation date for a new operation' do
          expect(Operation.first.operation_date).to eq Date.new(2014, 10, 11)
        end

        it 'assigns an amount date for a new operation' do
          expect(Operation.first.amount).to eq 18068.43
        end

        it 'assigns the reporter for a new operation' do
          expect(Operation.first.reporter).to eq 'TestReporter'
        end

        it 'assigns notes for a new operation' do
          expect(Operation.first.notes).to eq 'TestNotes'
        end

        it 'assigns status for a new operation' do
          expect(Operation.first.status).to eq 'TestStatus'
        end

        it 'assigns kind for new operation' do
          expect(Operation.first.kind).to eq 'category_1;category_2;category_3'
        end
      end

      context 'categories' do
        it 'add all category from field kind to operation' do
          perform!
          expect(Operation.first.categories.pluck(:name).sort).to eq %w(Category_1 Category_2 Category_3).sort
        end
      end
    end

    describe 'un-success' do
      let!(:existing_operation_for_unique_invoice_num) { create(:operation, invoice_num: 'UniqueInvoiceNum') }
      let!(:file) { Rails.root.join("spec/support/files/invalid_import_test.csv") }

      it 'will not add a new operations in the database' do
        expect { perform! }.to_not change(Operation, :count)
      end

      it 'will not add a new categories_operations in the database' do
        expect { perform! }.to_not change(CategoriesOperation, :count)
      end

      it 'will not add a new categories in the database' do
        expect { perform! }.to_not change(Category, :count)
      end
    end

    describe 'private methods' do
      describe '#find_company' do
        let!(:company_one) { create(:company, name: 'CompanyName') }

        it 'returns a company id' do
          expect(import.send(:find_company, 'CompanyName')).to eq company_one.id
        end
      end

      describe '#formatted_date' do
        let(:final_date) { Date.new(2016, 03, 16) }
        dates = ['2016-16-03', '2016-03-16', '03-16-2016', '03-2016-16', '16-03-2016', '16-2016-03',
                 '2016/16/03', '16/2016/03', '03/16/2016', '2016.16.03', '16.2016.03', '03.16.2016']

        it 'returns nil if the number of days is invalid' do
          expect(import.send(:formatted_date, Date._parse('32-12-2016'))).to eq nil
        end

        it 'return nil if the number of months is invalid' do
          expect(import.send(:formatted_date, Date._parse('19-19-2016'))).to eq nil
        end

        dates.each do |date|
          it "format #{date} to YYYY-MM-DD" do
            expect(import.send(:formatted_date, Date._parse(date))).to eq final_date
          end
        end
      end
    end
  end
end
