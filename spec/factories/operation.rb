FactoryGirl.define do

  sequence :invoice_num do |n|
    "Here is the invoice_num #{n}"
  end

  factory :operation do
    invoice_num
    invoice_date Date.new
    amount 10
    operation_date Date.new
    kind 'text'
    status 'text'
    company {create(:company)}
  end
end
