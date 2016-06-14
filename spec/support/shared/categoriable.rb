shared_examples_for 'Categoriable' do
  it 'create new objects CategoriesOperation' do
    expect { described_method }.to change(CategoriesOperation, :count).by(1)
  end

  it 'create new objects CategoriesOperation for operation in database' do
    expect { described_method }.to change(operation.categories_operations, :count).by(1)
  end

  it 'create join relations for operation in database' do
    described_method
    expect(CategoriesOperation.first.operation_id).to eq operation.id
  end

  it 'create join relations for category in database' do
    described_method
    expect(CategoriesOperation.first.category_id).to eq Category.first.id
  end

  it 'add category to operation.categories' do
    described_method
    expect(operation.categories).to include Category.first
  end

  it 'add operation to category.operations' do
    described_method
    expect(Category.first.operations).to include operation
  end
end
