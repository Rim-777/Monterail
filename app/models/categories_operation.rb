class CategoriesOperation < ActiveRecord::Base
  belongs_to :category
  belongs_to :operation

  validates :category_id, :operation_id, presence: true
end
