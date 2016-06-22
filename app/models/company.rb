require 'csv'
class Company < ActiveRecord::Base
  has_many :operations
  validates_presence_of :name

  def operations_number
    operations.count
  end

  def average_amount
    operations.average('amount')
  end

  def accepted_operations_num
    operations.where(status: 'accepted').count
  end

  def highest_month_operations
    operation =  operations.where(operation_date: Date.today.beginning_of_month..Date.today.end_of_month,
                            amount: operations.maximum(:amount)).first
      operation ? operation.amount : 0
  end

  def create_operations_csv(source)
    CSV.open(source.path, "wb") do |csv|
      csv << %w(company invoice_num invoice_date operation_date amount reporter notes status kind)
      operations.each do |operation|
        csv << [self.name,
                operation.invoice_num,
                operation.invoice_date,
                operation.operation_date,
                operation.amount,
                operation.reporter,
                operation.notes,
                operation.status,
                operation.kind
        ]
      end
    end
  end
end
