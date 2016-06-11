class CreateCategoriesOperations < ActiveRecord::Migration
  def change
    create_table :categories_operations do |t|
      t.belongs_to :category, index: true, foreign_key: true
      t.belongs_to :operation, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :categories_operations, [:category_id, :operation_id]
  end
end
