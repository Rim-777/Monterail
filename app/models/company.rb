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
      operation ? operation.amount: 0
  end
end
