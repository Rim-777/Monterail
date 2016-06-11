FactoryGirl.define do
  sequence :name do |n|
    "Company #{n}"
  end
  factory :company do
    name
  end
end
