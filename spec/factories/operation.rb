FactoryGirl.define do
  factory :operation do
    invoice_num "Here is the invoice_num"
    invoice_date Date.new
    amount 10
    operation_date Date.new
    kind 'text'
    status 'text'
    company {create(:company)}
  end
end
