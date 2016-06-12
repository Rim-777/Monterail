require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:categories_operations).dependent(:destroy)}
  it { should have_many(:operations).through(:categories_operations) }
  it { should validate_presence_of :name }

  describe "name uniqueness validations" do
    subject { create(:category) }
    it { should validate_uniqueness_of(:name) }
  end
end
