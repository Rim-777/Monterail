class CategoriesOperation < ActiveRecord::Base
  belongs_to :category
  belongs_to :operation

  validates_presence_of :category_id, :operation_id
  validates :category_id, uniqueness: { scope: :operation_id  }
end
