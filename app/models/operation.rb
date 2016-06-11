class Operation < ActiveRecord::Base
  has_many :categories_operations, dependent: :destroy
  has_many :categories, through: :categories_operations
  belongs_to :company

  validates_presence_of :company_id, :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num
end
