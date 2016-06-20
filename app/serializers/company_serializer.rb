class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :operations_number, :average_amount, :highest_month_operations, :accepted_operations_num

  has_many :operations

  def operations_number
    object.operations_number
  end

  def average_amount
    amount = object.average_amount
    amount.round(2) if amount
  end

  def accepted_operations_num
    object.accepted_operations_num
  end

  def highest_month_operations
    object.highest_month_operations
  end
end
