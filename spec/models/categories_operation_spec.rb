require 'rails_helper'

RSpec.describe CategoriesOperation, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:operation) }
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :operation_id }
end
