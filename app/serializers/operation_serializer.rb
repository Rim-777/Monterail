class OperationSerializer < ActiveModel::Serializer
  attributes :id, :company_id, :invoice_num, :invoice_date, :operation_date, :amount,
             :reporter, :notes, :status, :kind

end
