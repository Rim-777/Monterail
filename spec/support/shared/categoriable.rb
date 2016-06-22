shared_examples_for 'Categoriable' do
  it 'creates a new objects CategoriesOperation' do
    expect { described_method }.to change(CategoriesOperation, :count).by(1)
  end

  it 'creates a new objects CategoriesOperation for the operation in the database' do
    expect { described_method }.to change(operation.categories_operations, :count).by(1)
  end

  it 'creates join relations for the operation in the database' do
    described_method
    expect(CategoriesOperation.first.operation_id).to eq operation.id
  end

  it 'creates join relations for the category in the database' do
    described_method
    expect(CategoriesOperation.first.category_id).to eq Category.first.id
  end

  it 'add a category to operation.categories' do
    described_method
    expect(operation.categories).to include Category.first
  end

  it 'add the operation to category.operations' do
    described_method
    expect(Category.first.operations).to include operation
  end
end
