class Operation < ActiveRecord::Base
  has_many :categories_operations, dependent: :destroy
  has_many :categories, through: :categories_operations
  belongs_to :company

  validates_numericality_of :amount, greater_than: 0
  validates :invoice_num, uniqueness: true
  validates_presence_of :company_id, :invoice_num, :invoice_date,
                        :amount, :operation_date, :kind, :status

  def add_categories!
    define_categories
  end

  private
  def define_categories
    name_list = kind.split(';')
    present_categories = Category.where(name: name_list)
    name_list -= present_categories.pluck(:name)

    create_missing_categories_by(name_list)
    add_present_categories(present_categories)
  end

  def create_missing_categories_by(name_list)
    name_list.each do |name|
      categories.create(name: name.capitalize)
    end
  end

  def add_present_categories(categories_list)
    categories_list.each do |category|
      categories_operations.create(category_id: category.id)
    end
  end
end

