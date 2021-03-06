require 'csv'
class ImportService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def perform!
    if file_is_valid?
      CSV.foreach(file, headers: true) do |row|
        create_operation_by(row)
      end
    end
  end

  private
  def create_operation_by(row)
    if row.present?
      operation = Operation.find_or_initialize_by(
          company_id: (find_company(row['company'])),
          invoice_num: (formatted_name row['invoice_num']),
          invoice_date: date(row['invoice_date']),
          operation_date: date(row['operation_date']),
          amount: (formatted_decimal(row['amount'])),
          reporter: (formatted_name row['reporter']),
          notes: (formatted_name row['notes']),
          status: (formatted_name row['status']),
          kind: (formatted_name row['kind'])
      )
      operation.add_categories! if operation.save
    end
  end

  def find_company(name)
    if name
      company = Company.find_by(name: formatted_name(name))
      company.id if company
    end
  end

  def formatted_name(name)
    name.strip if name
  end

  def date(date)
    formatted_date(parsed_date(date)) if date
  end

  def parsed_date(date)
    Date._parse(date)
  end

  def formatted_date(date)
    year = date[:year]
    month = date[:mon]
    day = date[:mday]
    if year && month && day
      if Date.valid_date?(year, month, day)
        Date.new(year, month, day)
      elsif Date.valid_date?(year, day, month)
        Date.new(year, day, month)
      end
    end
  end

  def formatted_decimal(amount)
    amount.to_d if amount
  end

  def file_is_valid?
    file.to_s.split('\\').last.split('/').last.split('.').last == 'csv'
  end
end
