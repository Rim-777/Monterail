class Category < ActiveRecord::Base
  has_many :categories_operations, dependent: :destroy
  has_many :operations, through: :categories_operations
  validates_presence_of :name
end
