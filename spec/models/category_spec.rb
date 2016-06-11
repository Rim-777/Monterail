require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:categories_operations).dependent(:destroy)}
  it { should have_many(:operations).through(:categories_operations) }
  it { should validate_presence_of :name }
end