class OperationSerializer < ActiveModel::Serializer
  attributes :id, :company_id, :invoice_num, :invoice_date, :operation_date, :amount,
             :reporter, :notes, :status, :kind, :company_name

  def company_name
    object.company.name
  end
end
